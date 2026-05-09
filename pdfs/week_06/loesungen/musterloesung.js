var temperatureDataset = ee.Image('NASA/ASTER_GED/AG100_003'); // https://developers.google.com/earth-engine/datasets/catalog/NASA_ASTER_GED_AG100_003

var nightLightsDataset = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG') // https://developers.google.com/earth-engine/datasets/catalog/NOAA_VIIRS_DNB_MONTHLY_V1_VCMSLCFG?hl=en
  .filterDate('2021-01-01')
  .first();
  
var temperature = temperatureDataset.select('temperature').divide(100); // dataset is in 1/100 kelvin
var temperatureAverage = temperature.reduceNeighborhood(
  ee.Reducer.mean(),                  // calculate the mean
  ee.Kernel.square(2000, 'meters'),   // of a square with 'radius' of 2000 m (which is 4000 * 4000 m)
  "kernel",                           // using the kernel as the input weight
  true,                               // skipping masked or missing pixels in calculation
  "boxcar"                            // using the more efficient boxcar method to compute 
);
var temperatureDifferenceToSurrounding = temperature.subtract(temperatureAverage); 

var lights = nightLightsDataset.select('avg_rad').divide(60); // dataset is in range ~ 0 - 60, we want it normalized (0 - 1)
var lightsAverage = lights.reduceNeighborhood(
  ee.Reducer.mean(),
  ee.Kernel.square(4000, 'meters'), // use an area of 8000 * 8000 meters this time
  "kernel",
  true,
  "boxcar"
).multiply(10)
 .clamp(0, 1); // Multiplying and then clamping the value to 1 allows for light values as low as 0.1 to pass through the whole temperature in the next step

var weightedTemperatureDifference = temperatureDifferenceToSurrounding.multiply(lightsAverage); // use the lights as a kind of mask, so we only see temperature in cities


// This specifies how we want our data to be displayed.
var vis = {
  min: -10, // minimum value to consider (here: minus 10 degrees kelvin difference)
  max: 10, // maximum value to consider (here: plus 10 degrees kelvin difference)
  palette: [ // color palette for displaying, ranging from blue to red 
    '0602ff', '235cb1', '307ef3', '269db1', '30c8e2', '32d3ef', '3ae237',
    'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13', 'ff6e08',
    'ff500d', 'ff0000', 'de0101', 'c21301'
  ],
};

Map.setCenter(8.541111, 47.374444, 13); // Set map center and zoom to Zürich

Map.addLayer(weightedTemperatureDifference, vis, 'Temperature', true, 0.75); // Add our data as a map layer, with 75% opacity 

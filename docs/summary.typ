// ============================================================
// Exam Summary — Master Document
// ============================================================
// This is the single output file containing ALL weekly content.
// To add a new week: uncomment the corresponding #include line.
//
// Build: typst compile docs/summary.typ output/summary.pdf
//        or just: make build
// ============================================================

#import "template.typ": template, tip-box, warn-box, formula-box, cheat-box

#show: template.with(
  title: "Exam Summary",
  module: "Module Name",   // ← change this per module/branch
  author: "Student",
)

// ── Weeks ────────────────────────────────────────────────────
// Uncomment each week as it is studied and documented.

#include "weeks/week_01/index.typ"
#include "weeks/week_02/index.typ"
#include "weeks/week_03/index.typ"
#include "weeks/week_04/index.typ"
// #include "weeks/week_05/index.typ"
// #include "weeks/week_06/index.typ"
// #include "weeks/week_07/index.typ"
// #include "weeks/week_08/index.typ"
// #include "weeks/week_09/index.typ"
// #include "weeks/week_10/index.typ"
// #include "weeks/week_11/index.typ"
// #include "weeks/week_12/index.typ"

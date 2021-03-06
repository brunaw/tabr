context("outputs")

notes <- "r s a2~ a2 c3 c f4 f' d a f ce_g ceg#"
info <- "4. 4. 8*9 2. 4."
p1 <- glue(pct(p("a", 1)), rp(p(notes, info)))
p2 <- volta(p("r s a~ a c' c4 f5 f'' d4 a4 f' c'e_'g' c'e'g#'", info))
x1 <- track(p1) %>% score()
x2 <- track(p2, tuning = "DADGAD", ms_transpose = 1, ms_key = "flat") %>% score()
x3 <- track(glue(p1, p2), music_staff = NA) %>% score()

notes <- "a, b, c d e f g a"
p1 <- p(notes, 8)
p2 <- p(tp(notes, 7), 8)
p3 <- p(tp(notes, -12), 8)
x4 <- trackbind(track(p1, voice = 1),
                track(p2, voice = 2), tabstaff = c(1, 1)) %>% score()

chord_prep <- c("b_:m" = "x13321", "c/g" = "332o1o", "b:m/f#" = "(14)(12)(14)(14)(13)(12)", "r" = NA, "s" = NA)
chords <- chord_set(chord_prep)

test_that("chord_set returns as expected", {
  expect_equal(names(chords), names(chord_prep))
})

chord_seq <- setNames(c(4, 4, 2), names(chords[1:3]))
t1 <- trackbind(track(p1), track(p3, tuning = "bass", music_staff = "bass_8"))

x5 <- score(t1)
x6 <- score(t1, chords)
x7 <- score(t1, chord_seq = chord_seq)
x8 <- score(t1, chords, chord_seq)
x <- list(x1, x2, x3, x4, x5, x6, x7, x8)

header <- list(
  title = "my title", subtitle = "subtitle", composer = "composer", album = "album", arranger = "arranger",
  instrument = "instrument", meter = "meter", opus = "opus", piece = "piece", poet = "poet",
  copyright = "copyright", tagline = "tagline")
paper <- list(textheight = 230, linewidth = 160, indent = 20, fontsize = 16, first_page_number = 10,
              page_numbers = FALSE)

out <- file.path(tempdir(), c("out.ly", "out.pdf", "out.png"))
cleanup <- file.path(tempdir(), c("out.mid", "out.pdf", "out.png", "out.log"))
cl <- "NULL"

test_that("tab and lilypond functions run without error", {
  skip_on_appveyor()
  if(tabr_options()$lilypond != ""){
    expect_is(lilypond(x1, out[1]), cl)
    expect_is(lilypond(x1, basename(out[1]), path = tempdir()), cl)
    expect_is(tab(x1, out[2]), cl)
    expect_is(tab(x1, basename(out[2]), path = tempdir()), cl)
    expect_is(tab(x1, out[3]), cl)
    expect_is(tab(x1, basename(out[3]), path = tempdir()), cl)

    purrr::walk(x, ~expect_is(lilypond(.x, out[1]), cl))
    purrr::walk(x, ~expect_is(tab(.x, out[2], details = FALSE), cl))
    purrr::walk(x, ~expect_is(tab(.x, out[3], details = FALSE), cl))

    expect_error(tab(x8, out[2], "d_m", details = FALSE), "Invalid key.")

    purrr::walk(keys(), ~expect_is(tab(x8, out[2], .x, "2/2", "4 = 110",
                  header = header, string_names = FALSE, paper = paper,
                  endbar = FALSE, midi = FALSE, keep_ly = FALSE, details = FALSE), cl))

    expect_is(tab(x8, out[2], "c#", "2/2", "4 = 110",
                  header = c(header[c(1, 3, 4)], metre = "meter"), string_names = TRUE, paper = paper[1:5],
                  endbar = FALSE, midi = FALSE, keep_ly = FALSE, details = FALSE), cl)
    unlink(cleanup)
  }
})

test_that("miditab and midily functions run without error", {
  skip_on_appveyor()
  if(tabr_options()$midi2ly != "" || identical(Sys.getenv("TRAVIS"), "true")){
    midi <- system.file("example.mid", package = "tabr")
    expect_is(midily(midi, out[1]), cl)
    expect_is(miditab(midi, out[2]), cl)
    expect_is(miditab(midi, out[3], details = FALSE), cl)
    unlink(cleanup)
  }
})

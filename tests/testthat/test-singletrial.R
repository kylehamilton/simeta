context("singletrial")



# fuzz samples ------------------------------------------------------------

big <- runif(3, 4, 100)
small <- runif(3, 0.1, 0.9)

# tests -------------------------------------------------------------------

test_that("test tau2", {
  expect_is(singletrial(tau_sq = 0), "data.frame")
})

test_that("defaults return expected", {
  expect_is(singletrial(), "data.frame")
  expect_equal(nrow(singletrial()), 2)
})

test_that("true effect arg", {
  expect_is(singletrial(true_effect = 5), "data.frame")
})

test_that("effect ratio", {
  expect_is(singletrial(effect_ratio = 1), "data.frame")
  expect_gt(singletrial(effect_ratio = 1) %>% nrow(), 1)
  expect_is(metasim(trial_fn = singletrial, effect_ratio = 1),
            "data.frame")
  expect_is(
    metasim(trial_fn = singletrial, effect_ratio = 1.2),
    "data.frame"
  )
  expect_is(
    metasim(trial_fn = singletrial, effect_ratio = 1.2),
    "data.frame"
  )
})

test_that("distributions", {
  expect_is(singletrial(rdist = "pareto",
                        parameters = list(shape = 2, scale = 2)),
            "data.frame")
  expect_is(singletrial(
    rdist = "pareto",
    parameters = list(shape = round(big[[1]]), round(big[[2]]))
  ),
  "data.frame")
  expect_is(singletrial(rdist = "norm",
                        parameters = list(mean = big[[1]], sd = 2)),
            "data.frame")
  expect_is(singletrial(rdist = "exp",
                        parameters = list(rate = round(big[[1]]))),
            "data.frame")
  expect_is(singletrial(rdist = "lnorm",
                        parameters = list(mean = 3, sd = 1)),
            "data.frame")
})

test_that("singletrial in sims", {
  expect_is(metasim(trial_fn = singletrial),
            "data.frame")
  expect_is(metasims(
    single_study = TRUE,
    trial_fn = singletrial,
    progress = FALSE
    ),
  "sim_ss")
})

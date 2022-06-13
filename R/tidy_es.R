#' Extension of broom::tidy with effect size and APA formatting.
#'
#' @details Currently, the \code{tidy_es} only supports \code{lm} objects.
#'
#' @param x An object.
#' @param ... Further argument to be passed to further methods.
#'
#' @return A tibble.
#' @export
#'

tidy_es <- function(x, ...) {
    UseMethod("summary_es")
}

#' @export
tidy_es.lm <- function(x, ...) {
    df_residual <-
        broom::glance(x) |>
        purrr::pluck("df.residual", 1)

    ss_error   <- car::Anova(x, type = 3) |> dplyr::pull("Sum Sq") |> utils::tail(1)
    ss_total   <- car::Anova(x, type = 3) |> dplyr::pull("Sum Sq") |> sum()
    ss_effects <- car::Anova(x, type = 3) |> dplyr::pull("Sum Sq") |> utils::head(-1)

    eta_summary <-
        broom::tidy(x, conf.int = TRUE) |>
        dplyr::mutate(eta_squared         = ss_effects / ss_total,
                      partial_eta_squared = ss_effects / (ss_error + ss_effects),
                      APA                 = purrr::map(.data$term,
                                                       ~ JSmediation::apastylr(x, .x))) |>
        tidyr::unnest("APA")

    janitor::clean_names(eta_summary)
}

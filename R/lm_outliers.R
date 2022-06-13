#' Returns outlier indices
#'
#' Returns a \code{data.frame} with outlier indices for a specific  \code{lm}
#' model. Indices include studentized residuals, residuals' cook's distance,
#' and residuals' hat values.
#'
#' @param data A data.frame.
#' @param formula A model formula.
#' @param id A column name from \code{data} used to identify observations (optional).
#' @param verbose A boolean indicating whether the function should call print on
#'   the output. Useful when using \code{lm_outliers} with pipes.
#'
#' @examples
#' mtcars |>
#'   lm_outliers(mpg ~ disp) |>
#'   lm(mpg ~ disp,
#'      data = _)
#'
#' @author Dominique Muller, \email{dominique.muller@@univ-grenoble-alpes.fr}
#' @author Cédric Batailler, \email{cedric.batailler@@univ-grenoble-alpes.fr}
#'
#' @references Judd, C. M., McClelland, G. H., & Ryan, C. S. (2009). Data
#'   analysis: a model comparison approach (2nd ed). New York ; Hove: Routledge.
#'
#' @keywords outliers
#'
#' @import rlang
#' @importFrom stats hatvalues
#' @importFrom stats cooks.distance
#' @importFrom stats rstudent
#'
#' @export


lm_outliers <- function(data, formula, id, verbose = FALSE) {

  name_id <- enquo(id)
  fit <- stats::lm(formula, data)
  Out <- stats::model.frame(fit)
  Out$sdr <- stats::rstudent(fit)
  Out$cookd <- stats::cooks.distance(fit)
  Out$leverage <- stats::hatvalues(fit)

  outlier_data <-
    data |>
    dplyr::select(!!name_id) |>
    cbind(Out) |>
    dplyr::arrange(dplyr::desc("cookd")) |>
    tibble::as_tibble()

  if (verbose)
    print(outlier_data)

  outlier_data
}

#' Export a ggplot2 plot to a powerpoint document.
#'
#' @param plot Plot
#' @param file Path where the .pptx file should be saved.
#' @param w_r Wide to height ratio. Numeric.
#' @param template Powerpoint document template location. Defaults to an
#'                 internal powerpoint template.
#'
#' @return NULL
#' @export

ggplot_to_pptx <-
  function(plot = NULL, file, w_r = 1, template = NULL) {

    if(is.null(template)) {
      template_location <-
        system.file('pptx', 'template.pptx', package = "marguerite")
    }
    else {
      template_location <- template
    }

    if(!ggplot2::is.ggplot(plot))
      rlang::abort(message =
                     glue::glue("Error: `plot` argument must be a ggplot object:
                                         * You've supplied a {class(plot)} object."))

    plot_vectorial <- rvg::dml(ggobj = plot)

    officer::read_pptx(template_location) |>
      officer::ph_with(plot_vectorial,
                       location = officer::ph_location(left   = 0.1,
                                                       top    = 0.1,
                                                       width  = 9.8 / w_r,
                                                       height = 7.3)) |>
      print(target = file) |>
      invisible()
  }

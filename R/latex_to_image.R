#' Download a latex equation as an image
#'
#' Uses CodeCogs API to convert latex to an image, and then download the result.
#'
#' @param latex  A latex equation (character).
#' @param path   A path to save the image (character).
#' @param format The image format (supported: png, gif, svg).
#'
#' @return Invisibly returns the path.
#'
#' @export
latex_to_image <- function(latex, path, format = "png"){
  # Check whether format is supported (hard-coded)
  stopifnot("Format is not supported" = format %in% c("png", "gif", "svg"))

  # Build url
  image_url <-
    glue::glue("http://latex.codecogs.com/{format}.download?{latex}",
               latex =
                 URLencode(latex) %>%
                 stringr::str_replace_all("\\=", "%3D")
    )

  # Download and save
  req  <- httr2::request(image_url)
  httr2::req_perform(req, path = path)

  # Return path
  invisible(path)
}

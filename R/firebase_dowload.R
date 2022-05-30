#' Download a firebase realtime data base.
#'
#' @param url An URL pointing to a firebase realtime data base endpoint.
#' @param ref Defaults to "/".
#'
#' @return A list.
#' @export
#'
#' @examples
firebase_download <- function(url, ref = "/") {
    # prep request
    req <-
        glue::glue("{url}{ref}.json") |>
        httr2::request() |>
        httr2::req_headers(
            Accept = "application/json"
        )

    # perform the request
    resp <- httr2::req_perform(req)

    # export the json body
    httr2::resp_body_json(resp)
}

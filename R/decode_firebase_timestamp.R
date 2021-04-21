#' Decode a vector of firebase id into timestamp
#'
#' @param id Firebase id (charachter).
#'
#' @return A date (POSIXct)
#'
#' @export

decode_firebase_timestamp <- function(id) {
    id <- stringr::str_sub(id, 1, 8)
    unname(convert_firebase_id_v(id))
}


#' Convert a single firebase id to a timestamp

#' @param id The firebase id (charachter).
#'
#' @return A date (POSIXct)
#'
#' @references https://stackoverflow.com/questions/27908312/can-you-get-the-timestamp-from-a-firebase-array-key
#'
#' @keywords internal
convert_firebase_id <- function(id) {
    PUSH_CHARS <- "-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz";
    timestamp <- 0
    for (i in 1:stringr::str_length(id)) {
        c <- stringr::str_sub(id, i, i)
        timestamp = timestamp * 64 + (stringr::str_locate(PUSH_CHARS, c)[1] - 1)
    }
    timestamp / 1000

}

#' Vectorized version of \code{convert_firebase_id}
#'
#' @keywords internal
convert_firebase_id_v <-
    Vectorize(convert_firebase_id, "id")

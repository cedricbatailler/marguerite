test_that("decode_firebase_timestamp produced timestamps as intended", {

    firebase_id           <- "-MFdkH5qPe_6NCTqZ_3y"
    firebase_id_truncated <- "-MFdkH5q"

    firebase_timestamp    <- 1598428357046 / 1000

    firebase_id_decoded <- firebase_decode_timestamp(firebase_id)
    firebase_id_truncated_decoded <- firebase_decode_timestamp(firebase_id_truncated)

    expect_equal(firebase_id_decoded, firebase_timestamp)
    expect_equal(firebase_id_truncated_decoded, firebase_timestamp)
    expect_equal(firebase_id_decoded, firebase_id_truncated_decoded)

})

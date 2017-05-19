test_that("extract.file with decompress", {
  workdir <- tempdir()
  dir.create(sprintf("%s/tmp/", workdir))
  dir.create(sprintf("%s/tmp1/", workdir))
  test.file <- sprintf("%s/tmp1/test", workdir)
  file.create(test.file)
  gzip(test.file)
  x <- extract.file(sprintf("%s.gz", test.file), paste0(workdir, "/tmp"))
  expect_that(x, equals(TRUE))
  unlink(sprintf('%s/tmp', workdir), recursive=TRUE)
  unlink(sprintf('%s/tmp1', workdir), recursive=TRUE)
})

test_that("extract.file with decompress", {
  workdir <- tempdir()
  dir.create(sprintf("%s/tmp/", workdir))
  dir.create(sprintf("%s/tmp1/", workdir))
  test.file <- sprintf("%s/tmp1/test", workdir)
  file.create(test.file)
  gzip(test.file)
  x <- extract.file(sprintf("%s.gz", test.file), paste0(workdir, "/tmp"), decompress = FALSE)
  expect_that(x, equals(TRUE))
  unlink(sprintf('%s/tmp', workdir), recursive=TRUE)
  unlink(sprintf('%s/tmp1', workdir), recursive=TRUE)
})

test_that("drop_redundance_dir", {
  test.dir <- sprintf("%s/test_drop", tempdir())
  dir.create(test.dir)
  dir.create(sprintf("%s/a", test.dir))
  dir.create(sprintf("%s/a/b", test.dir))
  dir.create(sprintf("%s/a/c", test.dir))
  x <- drop_redundance_dir(test.dir)
  expect_that(x, equals(TRUE))
  unlink(test.dir, recursive=TRUE)
})

test_that("is.file.empty", {
  test.file <- sprintf("%s/1", tempdir())
  file.create(test.file)
  x <- is.file.empty(test.file)
  expect_that(x, equals(TRUE))
  x <- is.file.empty(tempdir())
  expect_that(x, equals(FALSE))
  unlink(test.file)
})

test_that("get.os", {
  x <- get.os()
  x <- x %in% c('centos', 'ubuntu', 'arch', 'other', 'windows', 'mac')
  expect_that(x, equals(TRUE))
})

test_that("runcmd & for_runcmd", {
  cmd <- ""
  x <- runcmd(cmd, verbose = FALSE)
  expect_that(x, equals(0))
  cmd <- sprintf("ls > %s/123", tempdir())
  x <- runcmd(cmd, verbose = FALSE)
  expect_that(x, equals(0))
  cmd <- rep("", 10)
  x <- for_runcmd(cmd, verbose = FALSE)
  expect_that(x, equals(rep(0,10)))
  cmd <- rep(sprintf("ls > %s/123", tempdir()), 10)
  x <- for_runcmd(cmd, verbose = FALSE)
  expect_that(x, equals(rep(0,10)))
  unlink(sprintf('%s/123', tempdir()))
})

test_that("get.subconfig", {
  config.1 <- list()
  x <- get.subconfig(config.1, "empty")
  expect_that(x, equals(""))
  config.1 <- list(debug=TRUE)
  x <- get.subconfig(config.1, "debug")
  expect_that(x, equals(TRUE))
  config.1 <- list(install = list(windows = "w", mac = "m", linux = "l"))
  x <- get.subconfig(config.1, "install")
  expect_that(x %in% c("w", "m", "l"), equals(TRUE))
  expect_that(sum(x %in% c("w", "m", "l")), equals(1))
})

test_that("get.file.type", {
  filetype.lib <- c("tgz", "tar.xz", "tar.bz2", "tar.gz", "tar", "gz", "zip", 
    "bz2", "xz")
  filenames <- sprintf("test.%s", filetype.lib)
  x <- sapply(filenames, function(x) {get.file.type(x)})
  x <- unname(x)
  expect_that(x, equals(filetype.lib))
})

test_that("download.file.custom", {
  url <- "http://www.baidu.com"
  destfile <- sprintf("%s/baidu.html", tempdir())
  x <- download.file.custom(url, destfile, quiet = T)
  expect_that(x, equals(0))
  unlink(destfile)
  destfile <- sprintf("%s/123", tempdir())
  x <- download.file.custom(url, destfile, is.dir = TRUE, quiet =T)
  expect_that(x, equals(0))
  unlink(destfile)
})


test_that("destdir.initial",{
  test.dir <- sprintf('%s/destdir.initial', tempdir())
  x <- destdir.initial(test.dir, FALSE, TRUE)
  expect_that(x, equals(TRUE))
  unlink(test.dir)
})

test_that("is.null.na",{
  x <- is.null.na(NULL)
  expect_that(x, equals(TRUE))
  x <- is.null.na(NA)
  expect_that(x, equals(TRUE))
})
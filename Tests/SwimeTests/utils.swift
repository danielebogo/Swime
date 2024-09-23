import Foundation

func loadFileData(path: String) -> Data {
  let url = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent(path)
  return try! Data(contentsOf: url)
}

let extensions = [
    "7z",
    "amr",
    "ar",
    "avi",
    "bmp",
    "bz2",
    "cab",
    "cr2",
    "crx",
    "deb",
    "dmg",
    "eot",
    "epub",
    "exe",
    "flac",
    "flif",
    "flv",
    "gif",
    "ico",
    "jpg",
    "jxr",
    "m4a",
    "m4v",
    "mid",
    "mkv",
    "mov",
    "mp3",
    "mp4",
    "mpg",
    "msi",
    "mxf",
    "nes",
    "ogg",
    "opus",
    "otf",
    "pdf",
    "png",
    "ps",
    "psd",
    "rar",
    "rpm",
    "rtf",
    "sqlite",
    "swf",
    "tar",
    "tar.Z",
    "tar.gz",
    "tar.lz",
    "tar.xz",
    "ttf",
    "wav",
    "webm",
    "webp",
    "wmv",
    "woff",
    "woff2",
    "xpi",
    "zip"
    ]

let mimeTypeByExtension = [
    "tar.Z": "application/x-compress",
    "tar.gz": "application/gzip",
    "tar.lz": "application/x-lzip",
    "tar.xz": "application/x-xz"
    ]

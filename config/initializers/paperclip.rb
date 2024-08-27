# MIMEタイプのマッピングを追加
Paperclip.options[:content_type_mappings] = {
  jpg: "image/jpeg",
  png: "image/png",
  webp: "image/webp",
  heic: "image/heic",
  heif: "image/heif",
  ico: "image/x-icon",
  gif: "image/gif"
}

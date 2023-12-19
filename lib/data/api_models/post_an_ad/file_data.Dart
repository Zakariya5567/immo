
class FileData {
  FileData({
    this.id,
    this.file,
    this.name,
    this.fileType,
    this.description,
    this.isMain,
  });

  int? id;
  String? file;
  String? name;
  String? fileType;
  String? description;
  bool? isMain;

  factory FileData.fromJson(Map<String, dynamic> json) => FileData(
        id: json["id"],
        file: json["file"],
        name: json["name"],
        fileType: json["file_type"],
        description: json["description"],
        isMain: json["is_main"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "name": name,
        "file_type": fileType,
        "description": description,
        "is_main": isMain,
      };
}
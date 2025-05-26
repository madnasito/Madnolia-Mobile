import 'package:madnolia/enums/report-type.enum.dart';

class UploadReportBody {
  ReportType type;
  String to;
  String description;
  String mediaPath;

  UploadReportBody({
    required this.type,
    required this.to,
    required this.description,
    required this.mediaPath,
  });
}
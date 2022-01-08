class AlertRequest {
  final String? title;
  final String? description;
  final String? buttonTitle;
  final bool? showNegativeButton;
  final String? buttonNegativeTitle;

  AlertRequest({
    this.title,
    this.description,
    this.buttonTitle,
    this.showNegativeButton,
    this.buttonNegativeTitle,
  });
}

class AlertResponse {
  final bool? confirmed;

  AlertResponse({
    this.confirmed,
  });
}

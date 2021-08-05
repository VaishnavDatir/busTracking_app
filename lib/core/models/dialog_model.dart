class AlertRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String buttonNegativeTitle;

  AlertRequest({
    this.title,
    this.description,
    this.buttonTitle,
    this.buttonNegativeTitle,
  });
}

class AlertResponse {
  final bool confirmed;

  AlertResponse({
    this.confirmed,
  });
}

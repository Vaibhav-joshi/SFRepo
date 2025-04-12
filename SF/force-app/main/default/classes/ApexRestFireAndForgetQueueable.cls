public inherited sharing class ApexRestFireAndForgetQueueable implements Queueable, Database.AllowsCallouts {
  private String jsonBody;
  public ApexRestFireAndForgetQueueable(String jsonBody) {
    this.jsonBody = jsonBody;
  }

  public void execute(QueueableContext context) {
    String responseBody = sendQueue();
  }
  private String sendQueue() {
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:InventoryManagementSystem/orders');
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/json');
    req.setBody(this.jsonBody);
    system.debug('~~req - ' + req);
    system.debug('~~jsonBody - ' + this.jsonBody);
    Http http = new Http();
    String responseBody;
    try {
      HttpResponse res = http.send(req);
      responseBody = res.getBody();
    } catch (Exception e) {
      responseBody = e.getMessage();
    }
    system.debug('~~responseBody - ' + responseBody);
    return responseBody;
  }
}
namespace Api.application.Entities
{
    public class MailRequest
    {
        public string Name { get; set; }
        public string ToEmail { get; set; }
        public string NameCompany { get; set; }
        public string Subject { get; set; }
        public string Message { get; set; }
    }
}

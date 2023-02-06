using System.Threading.Tasks;
using Api.application.Entities;
using Api.application.Interface;
using Api.application.Settings;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using MimeKit;

namespace Api.application.Service
{
    public class MailService : IMailService
    {
        private readonly MailSettings _mailSettings;
        public MailService(IOptions<MailSettings> options)
        {
            _mailSettings = options.Value;
        }
        public async Task SendEmailAsync(MailRequest mailRequest)
        {
            var email = new MimeMessage
            {
                Sender = MailboxAddress.Parse(_mailSettings.FromEmail)
            };

            email.To.Add(MailboxAddress.Parse(_mailSettings.ToMail));
            email.Subject = "Aurora Borealis - Fale Conosco";

            var builder = new BodyBuilder
            {
                HtmlBody = $"<b>Nome:</b> {mailRequest.Name} <br><br>  <b>Nome da Empresa:</b> {mailRequest.Subject}  <br><br>  <b>Email User:</b>  {mailRequest.EmailUser}  <br><br> <b>Mensagem:</b>  {mailRequest.Message}"
            };

            email.Body = builder.ToMessageBody();
            using var smtp = new SmtpClient();
            smtp.Connect(_mailSettings.Host, _mailSettings.Port, SecureSocketOptions.StartTls);
            smtp.Authenticate(_mailSettings.FromEmail, _mailSettings.Password);
            await smtp.SendAsync(email);
            smtp.Disconnect(true);
        }
    }
}

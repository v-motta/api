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
                Sender = MailboxAddress.Parse(_mailSettings.fromEmail)
            };

            email.To.Add(MailboxAddress.Parse(_mailSettings.ToMail));
            email.Subject = "Formul�rio Fale Conosco CED";

            var builder = new BodyBuilder
            {
                HtmlBody = $"Nome:{mailRequest.Name} <br>  Nome da Empresa: {mailRequest.NameCompany}  <br> Assunto:{mailRequest.Message} <br> Email User: {mailRequest.EmailUser}"
            };

            email.Body = builder.ToMessageBody();
            using var smtp = new SmtpClient();
            smtp.Connect(_mailSettings.Host, _mailSettings.Port, SecureSocketOptions.StartTls);
            smtp.Authenticate(_mailSettings.fromEmail, _mailSettings.Password);
            await smtp.SendAsync(email);
            smtp.Disconnect(true);
        }
    }
}

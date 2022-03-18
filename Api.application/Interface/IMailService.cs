using System.Threading.Tasks;
using Api.application.Entities;

namespace Api.application.Interface
{
    public interface IMailService
    {
        Task SendEmailAsync(MailRequest mailRequest);
    }
}

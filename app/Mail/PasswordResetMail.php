<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PasswordResetMail extends Mailable
{
    use Queueable, SerializesModels;

    public $mailData; // Dados do e-mail

    /**
     * Create a new message instance.
     *
     * @param array $mailData Dados necessários para o e-mail
     */
    public function __construct($mailData)
    {
        $this->mailData = $mailData;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        try {
            return $this->from(env('MAIL_FROM_ADDRESS', 'noreply@example.com'), env('MAIL_FROM_NAME', 'PortoBookShelf'))
                        ->subject('Password Reset Token')
                        ->view('emails.token-email') // Certifique-se que esta view existe
                        ->with('mailData', $this->mailData);
        } catch (\Exception $e) {
            // Log para rastrear falhas
            \Log::error('Error sending email: ' . $e->getMessage());
            throw $e;
        }
    }
}

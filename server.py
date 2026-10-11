import os
import datetime
import json

# ==========================================
# ENTERPRISE SECURITY & ANTI-CRIME HEADERS
# ==========================================
SECURITY_HEADERS = {
    "Content-Security-Policy": "default-src 'self' https: 'unsafe-inline' 'unsafe-eval'; img-src 'self' https: data:; frame-ancestors 'none';",
    "X-Frame-Options": "DENY",
    "X-Content-Type-Options": "nosniff",
    "X-XSS-Protection": "1; mode=block",
    "Referrer-Policy": "strict-origin-when-cross-origin",
    "Strict-Transport-Security": "max-age=31536000; includeSubDomains"
}

def record_visitor_telemetry(client_ip, user_agent):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = {"timestamp": timestamp, "ip": client_ip, "agent": user_agent}
    try:
        with open("visitor_analytics.log", "a") as f:
            f.write(json.dumps(log_entry) + "\n")
    except Exception as e:
        print(f"Telemetry error: {e}")

print("[+] Nollies Python Security Server initialized successfully.")

# ==========================================
# AUTOMATED EMAIL & SMS NOTIFICATION ENGINE
# ==========================================
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Configuration Placeholders (Set via Environment Variables or Config)
SMTP_SERVER = os.environ.get("SMTP_SERVER", "smtp.gmail.com")
SMTP_PORT = int(os.environ.get("SMTP_PORT", 587))
SENDER_EMAIL = os.environ.get("SENDER_EMAIL", "support@nollies-site.com")
SENDER_PASSWORD = os.environ.get("SENDER_PASSWORD", "your_app_password")

def send_email_notification(recipient_email, subject, body_text):
    """Sends an automated HTML/Text email to the user."""
    try:
        msg = MIMEMultipart()
        msg['From'] = SENDER_EMAIL
        msg['To'] = recipient_email
        msg['Subject'] = subject
        msg.attach(MIMEText(body_text, 'html'))

        # Standard TLS Connection
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.send_message(msg)
        server.quit()
        print(f"[+] Email notification sent to {recipient_email}")
        return True
    except Exception as e:
        print(f"[-] Email sending failed: {e}")
        return False

def send_sms_notification(phone_number, message_text):
    """Simulates/Triggers SMS Gateway integration (Twilio/Infobip API)."""
    # Placeholder for Twilio / Local SMS Gateway API call
    print(f"[+] SMS Notification triggered for {phone_number}: '{message_text}'")
    return True

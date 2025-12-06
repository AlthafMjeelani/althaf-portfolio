/// EmailJS Configuration
///
/// STEP-BY-STEP SETUP GUIDE:
///
/// 1. CREATE ACCOUNT:
///    - Go to https://www.emailjs.com/
///    - Click "Sign Up" and create a free account (200 emails/month free)
///
/// 2. CREATE EMAIL SERVICE (to get Service ID):
///    - After logging in, go to: https://dashboard.emailjs.com/admin
///    - Click on "Email Services" in the left sidebar
///    - Click "Add New Service"
///    - Choose "Gmail" (or your email provider)
///    - Connect your Gmail account (althafmdev@gmail.com)
///    - After setup, you'll see your SERVICE ID displayed (e.g., "service_abc123")
///    - Copy this Service ID and paste it below
///
/// 3. CREATE EMAIL TEMPLATE (to get Template ID):
///    - Click on "Email Templates" in the left sidebar
///    - Click "Create New Template"
///    - Set "To Email" field to: althafmdev@gmail.com
///    - Set "Subject" field to: {{subject}}
///    - Set "Content" field to:
///      From: {{from_name}}
///      Email: {{from_email}}
///
///      Subject: {{subject}}
///
///      Message:
///      {{message}}
///    - Click "Save"
///    - You'll see your TEMPLATE ID displayed (e.g., "template_xyz789")
///    - Copy this Template ID and paste it below
///
/// 4. GET PUBLIC KEY:
///    - Click on "Account" in the top menu bar
///    - Go to "General" tab
///    - Scroll down to "API Keys" section
///    - You'll see your PUBLIC KEY displayed (e.g., "abcdefghijklmnop")
///    - Copy this Public Key and paste it below
///
/// 5. REPLACE THE VALUES BELOW with your actual credentials
///
/// 6. IMPORTANT: ENABLE API REQUESTS IN EMAILJS:
///    - Go to EmailJS Dashboard → Account → Security
///    - Make sure "Allow requests from non-browser applications" is ENABLED
///    - This is required for Flutter web to work
///
/// 7. VERIFY YOUR EMAIL TEMPLATE VARIABLES:
///    - Go to Email Templates → Click on your template
///    - Check what variables you're using in the template (e.g., {{from_name}}, {{subject}})
///    - The code sends these parameters:
///      - from_name (sender's name)
///      - from_email (sender's email)
///      - subject (email subject)
///      - message (email message)
///      - user_name (same as from_name, for compatibility)
///      - user_email (same as from_email, for compatibility)
///      - reply_to (same as from_email, for reply-to field)
///    - Make sure your template uses variables that match these names
///    - The "To Email" should be set to: althafmdev@gmail.com (in template settings)
///    - Save the template after making changes
///
/// TROUBLESHOOTING:
/// - If emails aren't sending, check the error message shown in the form
/// - Verify all three IDs are correct (no extra spaces)
/// - Check EmailJS dashboard → Email Services → make sure service is "Active"
/// - Check EmailJS dashboard → Email Templates → verify template is saved
class EmailConfig {
  // Replace these with your EmailJS credentials
  static const String serviceId = 'service_efd5qss';
  static const String templateId = 'template_jutw2cf';
  static const String publicKey = 'ZL0an7FvYOxzrqlQ9';

  // Your email address where you want to receive messages
  static const String recipientEmail = 'althafmdev@gmail.com';

  // Check if EmailJS is configured
  static bool get isConfigured {
    return serviceId != 'YOUR_SERVICE_ID' &&
        templateId != 'YOUR_TEMPLATE_ID' &&
        publicKey != 'YOUR_PUBLIC_KEY';
  }
}

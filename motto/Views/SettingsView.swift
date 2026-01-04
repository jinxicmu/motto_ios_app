import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {

                
                Section(header: Text("About")) {
                    NavigationLink(destination: LegalDocumentView(title: "About Motto", content: """
**Motto.ai v1.0**

Welcome to Motto, your daily companion for mindfulness and inspiration.

**Version 1.0**
*   **Daily Wisdom:** Curated quotes from Eastern and Western philosophy.
*   **Zen Mode:** A focused breathing exercise to help you center yourself.
*   **Mindful Minutes:** Integration with Apple Health to track your mindfulness practice.
*   **Widgets:** Daily inspiration right on your home screen.

Thank you for being part of our journey.
""")) {
                        Text("Motto.ai v1.0")
                    }
                    
                    NavigationLink(destination: LegalDocumentView(title: "Our Philosophy", content: """
**Designed for Mindfulness**

In a world full of noise, Motto offers a moment of silence.

**One Breath at a Time**
We believe that mindfulness doesn't require hours of meditation. Sometimes, all it takes is one conscious breath and one powerful thought to shift your perspective.

**Eastern & Western Wisdom**
We bridge the gap between ancient philosophy and modern life, bringing you timeless truths from Laozi, Confucius, the Stoics, and more.

**Digital Minimalism**
Our design is intentional. No infinite feeds, no red notification dots (mostly). Just you, a thought, and a moment to breathe.
""")) {
                        Text("Designed for Mindfulness")
                    }
                }
                
                Section(header: Text("Legal")) {
                    NavigationLink(destination: LegalDocumentView(title: "Terms of Service", content: """
**Terms of Service**

*Last updated: January 2, 2026*

**1. Acceptance of Terms**
By accessing or using the Motto app ("the App"), you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the App.

**2. Use of Service**
Motto is provided for personal, non-commercial use to assist with mindfulness and daily inspiration. You agree not to misuse the App or help anyone else to do so.

**3. Medical Disclaimer**
The App provides mindfulness and breathing exercises for relaxation and stress reduction purposes only. It is not a medical device and does not provide medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.

**4. Intellectual Property**
The content, design, and intellectual property of the App are owned by Motto.ai. You may not copy, modify, distribute, or sell any part of the App or its content without our written permission.

**5. Third-Party Services**
The App integrates with third-party services, including but not limited to Google AdMob for advertising and Apple HealthKit for data synchronization. Your use of these services within the App is also subject to their respective terms and policies.

**6. Limitation of Liability**
To the fullest extent permitted by law, Motto.ai and its developers shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from (a) your access to or use of or inability to access or use the App; (b) any conduct or content of any third party on the App.

**7. Changes to Terms**
We reserve the right to modify these specific Terms at any time. We will provide notice of significant changes by updating the date at the top of these Terms. Your continued use of the App after any such change constitutes your acceptance of the new Terms of Service.

**8. Contact Us**
If you have any questions about these Terms, please contact us at support@motto.ai.
""")) {
                        Text("Terms of Service")
                    }
                    
                    NavigationLink(destination: LegalDocumentView(title: "Privacy Policy", content: """
**Privacy Policy**

*Last updated: January 2, 2026*

**1. Introduction**
Motto.ai ("we", "our", or "us") respects your privacy. This Privacy Policy explains how we collect, use, disclosure, and safeguard your information when you use our mobile application (the "App").

**2. Data Collection and Usage**

*   **Non-Personal Data:** We may collect non-personal data such as device usage statistics and crash logs to improve app stability and performance.
*   **Health Data:** The App integrates with Apple HealthKit to save your "Mindful Minutes". This data is read from and written directly to the Apple Health app on your device. We do not store this health data on our own servers, nor do we sell or share it with third parties for marketing purposes.
*   **Advertising Data:** We use Google AdMob to display advertisements. AdMob may collect and use personal data (such as your Advertising ID) to provide personalized ads. This is subject to your consent via the App Tracking Transparency prompt.

**3. Third-Party Services**
The App uses third-party services that may collect information used to identify you. Please refer to the privacy policies of these third-party service providers:
*   [Google AdMob](https://policies.google.com/privacy)
*   [Zarli SDK](https://www.zarli.ai/privacy)

**4. Data Security**
We implement reasonable security measures to protect the integrity of your data. However, please be aware that no method of transmission over the internet or method of electronic storage is 100% secure.

**5. Children's Privacy**
The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13.

**6. Changes to This Privacy Policy**
We may update our Privacy Policy from time to time. You are advised to review this page periodically for any changes. Use of the App after an update constitutes acceptance of the new policy.

**7. Contact Us**
If you have questions or suggestions about our Privacy Policy, do not hesitate to contact us at privacy@motto.ai.
""")) {
                        Text("Privacy Policy")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

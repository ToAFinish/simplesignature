# Configuring Default Settings

Following are steps to configure the app signature requests.

1. Go to Setup > Installed Packages and click on the "Configure" link next to the Simple Signature app.  If the paid version is enabled, you will see the options in the tables below.  Turn on or off the options according to what is defined below, and fill out any fields that are necessary.  Then click the Save Settings button.


| Option            | Description                                                                                              |
|-------------------|----------------------------------------------------------------------------------------------------------|
| Run Batch on Save | Run a job to email the blank and completed PDFs once the Signature is finished. |
| Attach PDF After Signature | Attach the completed PDF to the Signature record. |
| Attach PDF on Parent Record | After Signature	Attach the completed PDF to the parent record. |
| Email PDF to Contact after Signature | Email the completed PDF to the Contact on the Signature record. |
| Template VisualForce Page for PDF | This field must be populated with the name of the VisualForce page that will be used.  If either of the above items is set, then this one must also be set.  If you do not have a VisualForce page, you can use the default one: signature__BasicSignaturePDF |
| Default width (in pixels) for signature field (default = 500) | This is the width of the signature that will be saved for merging into an s-Docs template.  The smaller the value, the smaller the signature will appear.  If you are OK with the default of 500, then no need to enter anything different here, but it is a good idea to enter a number to avoid confusing in the future. |
| Base URL for images (e.g. https://XXX.my.salesforce/ or https://naXX.salesforce.com/) | This value can be gotten by clicking on the Home tab, and then copying the first part of the URL.  This is a critical component, so don't get this wrong or images will be broken. |
| Send Email to Partner | This should be turned on only if you are working with To A Finish technical support to enable the Partner option, where the signature requests are hosted in our Org.  This is used in particular with Profession edition. |
| Partner Email Address | This should be the email address given to you by To A Finish technical support. |

Now, we need to create a [Signature Request Button](SignatureRequestButton.md).

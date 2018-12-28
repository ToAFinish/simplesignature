# VisualForce PDF Template Creation

In this page we will discuss setting up a VisualForce page that will be used as the PDF where the final signature will be merged onto.  This VisualForce page will usually be formatted in a particular way, with the logo and other information of your company.  

>* <i>This is the most difficult part of the process and it cannot really be explained in a step-by-step tutorial.  If you do not already know how to create VisualForce pages, then you must either ask someone internally to do it, or you can use the Contact Us page in the app in order to ask us to do it for you.  We offer hourly services for this type of work if you don't have someone with the skills or time to do it.</i>

To get you started, you can use the included signature__BasicSignaturePDF page that is included with the app.  This page only list the legal wording, selected fields, and the signature on a simple form.  You can also download a copy of this page if you just want to make slight modifications to it, like adding your own logo.

   [GitHub.com Simple Signature Sample Code Repository](https://github.com/ToAFinish/simplesignature)

On the other hand, if you are using Opportunities or Quotes as the parent object, we also provide a sample VisualForce page that you can use as a starter.  Use these instructions to build it in a Sandbox or Dev org.  You will NOT be able to do it directly in Production, but rather, you need to do it in a Sandbox and then deploy it to Production.

* Note: these instructions assume you are setting it up for Opportunities, with Quotes change the instructions accordingly.

1. First you will need to add a static resource to your org that allows the signature process.  In Lightning, go to Setup > Custom Code > Static Resources.  In Classic, go to Setup > Develop > Static Resources.  Then press the "New" button.  Call the Static Resource "sampleinvoice", change the Cache Control to "Public" and then select a file called [SampleInvoice.zip](https://github.com/ToAFinish/simplesignature/blob/master/resources/SampleInvoice.zip) which you will need to download from the "resources" folder in our GitHub repository.

2. Next, create controller for your VisualForce page.  In Lightning, go to Setup > Custom Code > Apex Classes.  In Classic, go to Setup > Develop > Apex Classes.  Then press the "New" button.  <i>Note that this will only work inside of a Sandbox or Development org. You will not be able to do it directly in Production.  You will also need to have admin-level rights.  It also will not work in the Professional edition or below.  So if you do not see a "New" button, it will likely be one of those three reasons.</i>

3. Go back to the GitHub repository, in the "classes" folder, and open the SampleOpportunityPDFController file and copy all of the contents, without the line numbers.  Paste all of it into the Apex Class Salesforce window and Save.

> * You should also copy the SampleOpportunityPDFControllerTest file as another Apex Class if you intend to deploy it into production.

4. Finally, you will now need to create a new VisualForce page.  In Lightning, go to Setup > Custom Code > Visualforce Pages.  In Classic, go to Setup > Develop > VisualForce Pages.  Then, click the "New" button. 

5. Once you see a new bank VisualForce page, fill out the Label and Name fields and then delete all of the default content that is in the main VisualForce Markup area.  Now you are ready to put the actual code in.

6. Go back to the GitHub repository and this time go into the "pages" folder and click on the "SampleOpportunityPDF" entry.  Copy all of the text in this page (without the line numbers), starting with <apex:page  and ending with </apex:page>.  Paste all of this text into the VisualForce Markup area in Salesforce and then Save the page.

7.  Now go back to Setup > Custom Code > VisualForce Pages (or in Classic: Setup > Develop > VisualForce Pages) and find your new page on the list.  Click on the "Security" link next to the name of the new page.  A list of the profiles that can view this page will show up, you want to select all of them, or at least all of the ones who will use Simple Signature, and give them access. Save.

Once you are finished creating the page, you will need to assign it as the one to use in your Org. For that, we need to go to [Configure the default settings](ConfigureDefaultSettings.md).



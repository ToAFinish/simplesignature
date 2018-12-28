# Signature Requests for Quotes

Signature requests for Quotes in Salesforce is a special case because there are many ways of doing it, and none of them are very easy to do.  The main issue is that most Salesforce Sites (but not all of them) are unable to see Quotes or Quote Lines due to licensing restrictions.  So it becomes very difficult to show the customer the quote when the site licensing is not allowing you to.

Here are several different ways of doing signature requests with standard Salesforce Quotes:

## 1) 100% Custom

In this scenario, you would treat Quotes just like any other object and not try to use the pre-built Salesforce Quote functionality, including templates.  If you want to go this route, you can use the same instructions given with Opportunities as the example beginning wth [building the Quote PDF](VisualForcePDFTemplate.md).

> Note: If you are considering this option, please consider also possibly just using Opportunities instead of Quotes.  Some companies have been using Quote just for the quote template functionality, but this can also be provided just as easy with Opportunities, simplifying the process by removing the step where the sales person has to create a quote record.

## 2) Standard Templates Generated Via Code

In this scenario, we use the standard Salesforce Quote Template, but generate it via code.  This enables us to have just one custom button on the Quote that does all the work.  The process feels the same as it would with a different object.

1. First, we must build some code that will generate the template.  You can find some [sample code](https://github.com/ToAFinish/simplesignature/blob/master/classes/GenerateQuotePDF) in our "classes" folder.

2. Next, we must build a button to call this code.  Below is code for a JavaScript button.  We will be working towards providing a different button, as this is no longer a recommended option due to security concerns:

```JavaScript
{!REQUIRESCRIPT("/soap/ajax/43.0/connection.js")}
{!REQUIRESCRIPT("/soap/ajax/43.0/apex.js")}
 
var qId = '{!Quote.Id}';
var errorMsg = sforce.apex.execute("GenerateQuotePDF", "generateQuotePdf", {quoteIdList:qId});
 
if (errorMsg != '') alert(errorMsg);
else window.location.reload();
```

3. Finally, we must add a trigger to the Attachment or File object so that when the quote PDF is created, it will automatically send out the Signature Request using the quote.  You can find the [trigger code for attachments](https://github.com/ToAFinish/simplesignature/blob/master/triggers/CreateSignature_Attachments) or [trigger code for files](https://github.com/ToAFinish/simplesignature/blob/master/triggers/CreateSignatureOnFile) in the "triggers" folder.

## 3) Standard Templates, Standard Process, Attachment Trigger

In this scenario, we use the standard Salesforce Quote Template, and use the standard Create PDF button to generate the PDF.  Then, when the PDF is saved (not emailed), the same trigger in the prior scenario would be utilized to send out the signature request.

Other, more advanced, scenarios exist.  If you need help with a more advanced solution, please contact us using the Contact Form in the Signature App.

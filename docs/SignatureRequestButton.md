# Signature Requests Button

Creating a button on the parent object where you need a signature will allow you to request one.  For example, if you need a signature on a Case, or an Opportunity or on your own custom object, you would set up the button on this object.  For these instructions, we will give you instructions for buttons off of a Contact, an Opportunity, and a Quote.

1. <b>Create a New Button</b>.  Using Opportunities as an example: In Lightning, go to Setup > Object Manager > Opportunity > Buttons, Links and Actions, and click the New Button or Link button.  In Classic, at the top-right of the page click on Setup > Customize > Opportunities > Buttons, Links and Actions, and click the New Button or Link button.
2. <b>Give the button a Name and Label</b> like "Request Signature", set the Display Type as "Detail Page Button", set the Behavior to "Display in existing window without sidebar or header" and make sure the Content Source is URL.
3. <b>Add code to the button</b>.  In the main code area below, paste the following if you are starting from Contact parent record:

```javascript
/apex/signature__RequestSignature
?Id={!Contact.Id}
&templateName=c__MyVFPage
```

Or from a Quote:

```javascript
/apex/signature__RequestSignature
?Id={!Quote.Id}
&templateName=c__MyVFPage
&contactField=ContactId
```

Or from an Opportunity (use your own custom Contact lookup field API name):

```javascript
/apex/signature__RequestSignature
?Id={!Opportunity.Id}
&templateName=c__MyVFPage
&contactField=PrimaryContact__c
```

Or from a Custom object (use your own API names):

```javascript
/apex/signature__RequestSignature
?Id={!Custom_Object__c.Id}
&templateName=c__MyVFPage
&contactField=Custom_Lookup_to_Contact__c
```

You will need to change the parameters Id, templateName, and contactField as explained below:

| Parameter              | Description                                                                    |
|------------------------|--------------------------------------------------------------------------------|
| Id | The Id field of the parent object.  For Opportunities it would be {!Opportunity.Id}, for Contacts {!Contact.Id}, for Quotes {!Quote.Id} or for a custom object {!Custom_Object__c.Id}.  (Use the Insert Field functionality provided to make sure you enter it correctly.) |
| templateName | This is optional if you want to use a different VisualForce page from that one you set up in the Configuration step above.  You can create multiple buttons for different forms, if you change this one parameter. [More about PDF templates here](http://www.google.com). |
| contactField | This is the API name of the Contact lookup field on the Parent object. For Quotes it would be ContactId, for Contacts it is not needed, since you are starting from a Contact, and for other objects like Opportunity or Account or custom objects, it needs to be a custom lookup field to the Contact object.  Note that this field is needed whenever doing a Signature Request because it is automatically emailed when the button is pressed.  The process needs to know which Contact field to use. If you do not include this parameter, then you must somehow let the signature record know which email address to send to.  See the advanced options below. |

4. <b>Save the button</b>
5. <b>Add the button to the page layout</b>  Using Opportunities as an example: In Lightning, go to Setup > Object Manager > Opportunity > Page Layouts, and add it into one or more page layouts (you will find the button in the "Mobile & Lightning Actions" category.  In Classic, go to Support > Customize > Opportunities > Page Layouts and add it into one or more page layouts (you will find the button in the "Buttons" category).

You may continue your configuration of signature requests by [Setting up the Site](SiteSetup.md), or read on below for advanced options.

## Advanced Setup

In order to tell Simple Signature who to send the signature request to, you must do one of the following:

1. Use the "contactField" parameter when creating the signature request, as described above.
2. Use a process or trigger to populate the Email (signature__Email__c), First Name (signature__Name__c), and Last Name (signature__Name_2__c) fields when the Signature record is created.  If the Contact field is not populated, then this is the way to get the request out.
3. Use a process or trigger to populate the Contact (signature__Contact__c) lookup field with a valid Contact Id.  Here is a [sample trigger](https://github.com/ToAFinish/simplesignature/blob/master/classes/SampleOpportunityPDFController) (and [test class](https://github.com/ToAFinish/simplesignature/blob/master/classes/SampleOpportunityPDFControllerTest)) to accomplish that for Opportunities. 

Continue your configuration of signature requests by [Setting up the Site](SiteSetup.md).

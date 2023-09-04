import { LightningElement, api } from 'lwc';
import page_Title from '@salesforce/label/c.Page_Title';
import { CloseActionScreenEvent } from 'lightning/actions';
import signatureLogo from '@salesforce/resourceUrl/SSLogo';

export default class TestLeadSignatureLWC extends LightningElement {
    @api recordId;
    page_TitleLabel = page_Title;
    signatureLogo = signatureLogo;
    retrievedRecordId = false;

    renderedCallback() {
        if (!this.retrievedRecordId && this.recordId) {
            this.retrievedRecordId = true; // Escape case from recursion
            console.log('Found recordId: ' + this.recordId);
        }
    }

    CloseActionScreenEvent(e) {
        console.log('*************************************close method called**********************************************************');
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}

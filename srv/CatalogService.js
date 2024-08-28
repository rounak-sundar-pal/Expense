const cds = require("@sap/cds");

module.exports = cds.service.impl( async function () {
    const {
        MemberMaster,
        MemberPayment
    } = this.entities;

    this.before('CREATE', MemberMaster , async (req,res) => {
        var results = [];
        var lv_phoneNo = req.data.phoneNo.slice(-10);

        results = await cds.tx(req).run(SELECT.from(MemberMaster).where({phoneNo : {like : lv_phoneNo}}));
        console.log(results);

        if (results.length > 0) {
            req.error(500, "Phone Number already registered");
        }

    });

    this.before('READ' , MemberMaster , async (req,res) =>{
        console.log(req.data);
    });

    this.before('CREATE' , MemberPayment , async (req,res) => {

        if (req.data.memberId.trim() === '') {
            req.error(500, "Please provide Member ID");
        }

    });

    
})
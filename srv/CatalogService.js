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

    this.on('boost' , async(req,res) => {
        try {
            const ID = req.params[0];
            console.log("Member Master UUID"+ ID + "Gender will be changed to F");
            const tx = cds.tx(req);
            await tx.update(MemberMaster).where({ID : ID}).with({
                gender : 'F'
            });
            return "Boost was successfull";
        } catch (error) {
            return "Error" + error.toString();
        }
    })

    
})
const { db, isArray, isEmpty, logErr } = require("../util/helper");

exports.getList = async (req, res) => {
    try {
        var txtSearch = req.query.txtSearch;
        var sql = "SELECT * FROM expenses ";
        if (!isEmpty(txtSearch)) {
            sql += " WHERE ref_no LIKE :txtSearch";
        }
        const [list] = await db.query(sql, {
            txtSearch: "%" + txtSearch + "%",
        });
        res.json({
            list: list,
        });
    } catch (error) {
        logErr("customer.getList", error, res);
    }
};
// id,name,code,tel,email,address,website,note,create_by,create_at
// id,:name,:code,:tel,:email,:address,:website,:note,:create_by,:create_at
exports.create = async (req, res) => {
    try {
        var sql =
            "INSERT INTO customer (name,code,tel,email,address,website,note,create_by) VALUES (:name,:code,:tel,:email,:address,:website,:note,:create_by) ";
        var [data] = await db.query(sql, {
            ...req.body,
            create_by: req.auth?.name,
        });
        res.json({
            data: data,
            message: "Insert success!",
        });
    } catch (error) {
        logErr("customer.create", error, res);
    }
};

exports.update = async (req, res) => {
    try {
        var sql =
            "UPDATE  customer set name=:name, code=:code, tel=:tel, email=:email, address=:address, website=:website, note=:note WHERE id=:id ";
        var [data] = await db.query(sql, {
            ...req.body,
        });
        res.json({
            data: data,
            message: "Update success!",
        });
    } catch (error) {
        logErr("customer.update", error, res);
    }
};

exports.remove = async (req, res) => {
    try {
        var [data] = await db.query("DELETE FROM customer WHERE id = :id", {
            ...req.body,
        });
        res.json({
            data: data,
            message: "Data delete success!",
        });
    } catch (error) {
        logErr("customer.remove", error, res);
    }
};

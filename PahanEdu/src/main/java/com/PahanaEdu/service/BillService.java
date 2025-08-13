package com.PahanaEdu.service;

import com.PahanaEdu.dao.BillDAO;
import com.PahanaEdu.model.Bill;

import java.util.List;

public class BillService {

    private BillDAO billDAO;

    public BillService() {
        this.billDAO = new BillDAO();
    }

    public List<Bill> getLastFiveBills() {
        return billDAO.getLastFiveBills();
    }

}

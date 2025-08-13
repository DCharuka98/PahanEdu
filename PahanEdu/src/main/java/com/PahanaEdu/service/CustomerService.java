package com.PahanaEdu.service;

import com.PahanaEdu.dao.CustomerDAO;
import com.PahanaEdu.model.Customer;
import java.util.List;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();

    public boolean addCustomer(Customer customer) {
        return customerDAO.addCustomer(customer);
    }
    
    public boolean isNICExists(String nic) {
        return customerDAO.isNICExists(nic);
    }

    
    public Customer getCustomerById(int id) {
        return customerDAO.getCustomerById(id);
    }

    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    public boolean updateCustomer(Customer customer) {
        return customerDAO.updateCustomer(customer);
    }

    public boolean deleteCustomer(int id) {
        return customerDAO.deleteCustomer(id);
    }
    
    public String generateNextAccountNumber() {
        return customerDAO.generateNextAccountNumber();
    }
    
    public List<Customer> searchCustomersByNameOrNIC(String query) {
        return customerDAO.searchCustomersByNameOrNIC(query);
    }
}

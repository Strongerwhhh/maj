package com.wzy.dao;

import com.wzy.pojo.MajUser;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class UserDao {
    private static SessionFactory sessionFactory;

    public static Session getSession() {
        if (sessionFactory == null || sessionFactory.isClosed()) {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        }

        return sessionFactory.getCurrentSession();
    }


    public MajUser selectUser(String userid){
        Session session = getSession();
        String hql = "from MajUser where userId=:id ";
        Transaction transaction = session.beginTransaction();
        Query<MajUser> query = session.createQuery(hql, MajUser.class);
        query.setParameter("id",userid);
        Iterator it = query.setCacheable( true ).list().iterator();
        transaction.commit();
        while( it.hasNext() ) {
            return (MajUser) it.next();
        }
        return null;
    }

    public int deleteUserById(List<String> idList){
        Session session = getSession();
        String hql="delete from MajUser where userId in(:idList)";
        Transaction transaction = session.beginTransaction();
        Query<?> query = session.createQuery(hql).setParameter("idList", idList);
        int i = query.executeUpdate();
        transaction.commit();
        return i;
    }

    public boolean saveOrUpdateUser(MajUser user) {
        Session session = getSession();
        Transaction transaction = null;
        int i=0;
        try {
            transaction = session.beginTransaction();
            session.saveOrUpdate(user);
            transaction.commit();
            return true;
        } catch (HibernateException e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return false;
    }

}

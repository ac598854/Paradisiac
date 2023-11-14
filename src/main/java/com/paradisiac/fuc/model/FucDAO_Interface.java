package com.paradisiac.fuc.model;

import java.util.List;


public interface FucDAO_Interface {
    public void insert(FucVO fucVO);
    public void update(FucVO fucVO);
    public void delete(Integer fucNo);
    public FucVO findByPrimaryKey(Integer fucNo);
    public List<FucVO> getAll();

}

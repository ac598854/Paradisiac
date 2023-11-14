package com.paradisiac.product.dto;

public class OrderQueryParams {
    private Integer memno;
    private Integer limit;
    private Integer offset;

    public Integer getMemno() {
        return memno;
    }

    public void setMemno(Integer memno) {
        this.memno = memno;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }
}

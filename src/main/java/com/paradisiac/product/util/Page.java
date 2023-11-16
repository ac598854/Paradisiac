package com.paradisiac.product.util;

import java.util.List;

public class Page<T> {
    private Integer limit;
    private Integer offset;
    private Integer total;
    private List<T> results;
    private Integer currentPage;
    private Integer totalPages;

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

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getResults() {
        return results;
    }

    public void setResults(List<T> results) {
        this.results = results;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }
    public void calculatePageData() {
        this.currentPage = this.offset / this.limit + 1;
        this.totalPages = (int) Math.ceil((double) this.total / this.limit);
    }
}

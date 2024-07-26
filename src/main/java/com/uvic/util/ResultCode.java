package com.uvic.util;

/**
 * Common return object
 */
public enum ResultCode implements IErrorCode {
    SUCCESS(200, "Operation Success"),
    FAILED(500, "Operation Failed"),
    VALIDATE_FAILED(404, "参数检验失败");
    private long code;
    private String message;

    private ResultCode(long code, String message) {
        this.code = code;
        this.message = message;
    }

    public long getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}

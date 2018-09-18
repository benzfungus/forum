package cn.benzfungus.forum.exception;

public class UserExistException extends Exception {
    public UserExistException(String errorMsg) {
        super(errorMsg);
    }
}
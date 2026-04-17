module nccl_fort_mod
    use iso_c_binding
    implicit none
   
    integer(c_int), parameter :: ncclFloat64 = 8 
    integer(c_int), parameter :: ncclFloat32 = 7
    integer(c_int), parameter :: ncclSum     = 0

    type, bind(c) :: ncclUniqueId
        character(c_char) :: internal(128)
    end type ncclUniqueId

    interface
        integer(c_int) function ncclGetUniqueId(id) bind(c, name="ncclGetUniqueId")
            import :: c_int, ncclUniqueId
            type(ncclUniqueId) :: id
        end function ncclGetUniqueId

        integer(c_int) function ncclCommInitRank(comm, nranks, id, rank) bind(c, name="ncclCommInitRank")
            import :: c_int, c_ptr, ncclUniqueId
            type(c_ptr) :: comm
            integer(c_int), value :: nranks
            type(ncclUniqueId), value :: id
            integer(c_int), value :: rank
        end function ncclCommInitRank

        integer(c_int) function ncclCommDestroy(comm) bind(c, name="ncclCommDestroy")
            import :: c_int, c_ptr
            type(c_ptr), value :: comm
        end function ncclCommDestroy

        integer(c_int) function ncclGroupStart() bind(c, name="ncclGroupStart")
            import :: c_int
        end function ncclGroupStart

        integer(c_int) function ncclGroupEnd() bind(c, name="ncclGroupEnd")
            import :: c_int
        end function ncclGroupEnd

        integer(c_int) function ncclSend(sendbuff, count, datatype, peer, comm, stream) bind(c, name="ncclSend")
            import :: c_ptr, c_size_t, c_int
            type(c_ptr), value :: sendbuff
            integer(c_size_t), value :: count
            integer(c_int), value :: datatype
            integer(c_int), value :: peer
            type(c_ptr), value :: comm
            type(c_ptr), value :: stream
        end function ncclSend

        integer(c_int) function ncclRecv(recvbuff, count, datatype, peer, comm, stream) bind(c, name="ncclRecv")
            import :: c_ptr, c_size_t, c_int
            type(c_ptr), value :: recvbuff
            integer(c_size_t), value :: count
            integer(c_int), value :: datatype
            integer(c_int), value :: peer
            type(c_ptr), value :: comm
            type(c_ptr), value :: stream
        end function ncclRecv

        integer(c_int) function ncclAllReduce(sendbuff, recvbuff, count, datatype, op, comm, stream) bind(c, name="ncclAllReduce")
            import :: c_ptr, c_size_t, c_int
            type(c_ptr), value :: sendbuff
            type(c_ptr), value :: recvbuff
            integer(c_size_t), value :: count
            integer(c_int), value :: datatype
            integer(c_int), value :: op
            type(c_ptr), value :: comm
            type(c_ptr), value :: stream
        end function ncclAllReduce
    end interface
end module nccl_fort_mod

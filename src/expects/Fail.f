!
! A unit testing library for Fortran.
!
! The MIT License
!
! Copyright 2011-2016 Andrey Pudov.
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the 'Software'), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
!
! The above copyright notice and this permission notice shall be included in
! all copies or substantial portions of the Software.
!
! THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
! THE SOFTWARE.
!

submodule (Unit) FailExpects

    implicit none

contains
    module subroutine fail_expect(message, default)
        character(len=*), optional, intent(in) :: message
        character(len=*), optional, intent(in) :: default

        class(UnitCaseEntry), pointer :: case
        class(UnitLogger),    pointer :: logger
        type(UnitContext) context

        case   => context%getCase()
        logger => context%getLogger()

        case%status = .false.
        if (present(message)) then
            call logger%log(type = TYPE_CASE, name = case%name, details = message, status = case%status)
        else
            call logger%log(type = TYPE_CASE, name = case%name, details = default, status = case%status)
        end if
    end subroutine
end submodule

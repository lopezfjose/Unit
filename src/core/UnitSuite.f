!
! A unit testing library for Fortran
!
! The MIT License
!
! Copyright 2011-2016 Andrey Pudov
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

submodule (Unit) UnitSuite
contains
    module subroutine init_suite(self)
        class(UnitSuite), intent(in out) :: self

        self%list => null()
        self%last => null()

        print '(/a)', 'init default suite'
    end subroutine

    module subroutine clean_suite(self)
        class(UnitSuite), intent(in out) :: self
        type(UnitCaseEntry), pointer     :: entry

        do while (associated(self%list))
            entry => self%list
            self%list => self%list%next

            deallocate(entry)
        end do
    end subroutine

    module subroutine add_suite(self, case)
        class(UnitSuite), intent(in out)     :: self
        class(UnitCase), pointer, intent(in) :: case

        type(UnitCaseEntry), pointer :: entry
        type(UnitCaseEntry), pointer :: previous

        print *, 'add default suite'

        allocate(entry)
        entry%next => null()
        entry%case => case

        print *, 'INIT CASES'

        call entry%case%init()
        !call case%init()

        if (.not. associated(self%last)) then
            self%list => entry
        else
            previous      => self%last
            previous%next => entry
        end if

        self%last => entry
    end subroutine

    module subroutine run_suite(self)
        class(UnitSuite), intent(in) :: self
        type(UnitCaseEntry), pointer :: entry

        entry => self%list

        do while (associated(entry))
            call entry%case%run()

            entry => entry%next
        end do
    end subroutine
end submodule

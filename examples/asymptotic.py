##
##*********************************************************************************
##    Copyright (C) 2020, 2023 Mesut Karakoc
##
##    This file is part of AIMpy.
##
##    AIMpy is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    AIMpy is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with AIMpy.  If not, see <https://www.gnu.org/licenses/>.
##*********************************************************************************
##
import symengine as se
import sympy as sym
import flint as ft
from IPython.display import display, Math, Latex

# to write fractional numbers as inifinite precision rational numbers
o = se.Integer(1)
# Example:
# 1/2 = o* 1/2

def display_dict(pdict, pprec=None):
    """
    Show keys and values of a dictionary as equalities.
    Example: keys = values
    """
    p_keys = map(lambda x: sym.latex(x), pdict.keys())
    if pprec==None:
        p_tex = ",~~".join(sorted(["%s = %s"%(p[0], p[1]) for p in zip(p_keys, pdict.values())]))
    else:
        p_tex = ",~~".join(sorted(["%s = %s"%(p[0], sym.N(p[1], pprec)) for p in zip(p_keys, pdict.values())]))
    display(Math(p_tex))    

def symPrintFunc(func, var):
    """
    Print equation like functions.
    """
    var_str = map(lambda s: sym.latex(s), var)
    display(Math(sym.latex(sym.S(func.__name__)) +  r'(%s) = '%",".join(var_str) +sym.latex(sym.S(func(*var)))))
    
def iimag(i):
    """
    It can be used to check if a number has imaginary part,
    and it is postive or negative
    """
    try:
        return float(i.imag.str(radius=False))
    except:
        return i.imag.mid_rad_10exp(1)[0]

def ireal(i):
    """
    It can be used to check if a number has real part,
    and it is postive or negative
    """
    try:
        return float(i.real.str(radius=False))
    except:
        return i.real.mid_rad_10exp(1)[0]

class aim(object):
    """
    Asymptotic Iteration Method solver
    """
    
    def __init__(self, l0, s0, pl0, ps0):
        self.l0 = l0
        self.s0 = s0
        self.pl0 = pl0
        self.ps0 = ps0        
        self.nl0 = l0.subs(pl0)
        self.ns0 = s0.subs(ps0)
    
    # displays numeric values of symbols of l0 and s0 
    def display_parameters(self, pprec=None):
        display(Math(r'\text{Values of the parameters of } \lambda_0:'))
        display_dict(self.pl0, pprec)
        display(Math(r'\text{Values of the parameters of } s_0:'))
        display_dict(self.ps0, pprec)
        
    # display l0, s0
    def display_l0s0(self, select, pprec=None):
        """
        select == 0:      show both l0, s0
        select == 1:  show symbolic l0, s0
        select >= 2: show numerical l0, s0
        """
        if pprec==None:
            printList = tuple(map(lambda x: sym.latex(sym.S(x)), [self.l0, self.s0, self.nl0, sym.N(self.ns0)]))
        else:
            printList = tuple(map(lambda x: sym.latex(sym.S(x)), [self.l0, self.s0, sym.N(self.nl0, pprec), sym.N(self.ns0, pprec)]))
        if select == 0:
            display(Math(
               r"""           
                \begin{align}
                \lambda_0 &= \left[%s \right.\\ 
                      s_0 &= \left[%s \right.\\ 
                \lambda_0 &= \left[%s \right.\\ 
                      s_0 &= \left[%s \right.
                \end{align}
                """%printList))
        elif select == 1:
            display(Math(
                r"""           
                \begin{align}
                \lambda_0 &= \left[%s \right.\\ 
                      s_0 &= \left[%s \right.
                \end{align}
                """%printList[:2]))
        elif select >= 2:
            display(Math(
                r"""           
                \begin{align}
                \lambda_0 &= \left[%s \right.\\ 
                      s_0 &= \left[%s \right.
                \end{align}
                """%printList[2:]))
            
    def printRoots(self, n, allRoots, showRoots=None, printFormat="{:30.25f}", col=(0,4), dprec=500):
        """
        Roots will be printed using:
        showRoots: Choose the set of numbers (Real or Imaginary).
        choose which real roots will be printed,
                   r: all real roots
                  -r: negative real roots 
                  +r: positive real roots
        choose which complex roots will be printed,
                +r+i: +real and +imaginary
                -r+i: -real and +imaginary
                -r-i: -real and -imaginary
                +r-i: +real and -imaginary
                   
        printFormat: Number formatting. The default format is {:30.25f}
        col: Choose how many roots will be displayed. The default value is (0,4).
        dprec: Precision of the roots. The default value is 500.
        """
        if showRoots != None:
            if  showRoots == 'r':    # real roots
                filteredSols = [i.real.str(radius=False) for i in allRoots if iimag(i)==0]
            
            if  showRoots == '-r':   # negative real roots
                filteredSols = [i.real.str(radius=False) for i in allRoots if iimag(i)==0 and i.real<0]
                
            elif showRoots == '+r':  # positive real roots
                filteredSols = [i.real.str(radius=False) for i in allRoots if iimag(i)==0 and i.real>0]
                
            elif showRoots == 'i':   # complex roots
                filteredSols = [[i.real.str(radius=False), i.imag.str(radius=False)] for i in allRoots if iimag(i)!=0 and abs(ireal(i))>0]

            elif showRoots == '+r+i': # complex roots with +real and +imag
                filteredSols = [[i.real.str(radius=False), i.imag.str(radius=False)] for i in allRoots if iimag(i)>0 and ireal(i)>0]
            elif showRoots == '-r+i': # complex roots with +real and +imag
                filteredSols = [[i.real.str(radius=False), i.imag.str(radius=False)] for i in allRoots if iimag(i)>0 and ireal(i)<0]
            elif showRoots == '-r-i': # complex roots with +real and +imag
                filteredSols = [[i.real.str(radius=False), i.imag.str(radius=False)] for i in allRoots if iimag(i)<0 and ireal(i)<0]
            elif showRoots == '+r-i': # complex roots with +real and +imag
                filteredSols = [[i.real.str(radius=False), i.imag.str(radius=False)] for i in allRoots if iimag(i)<0 and ireal(i)>0]               
            # format printing
            try: 
                if filteredSols != []:
                    if 'i' in showRoots: # complex numbers
                        printFormatC = printFormat+printFormat+"j"
                        printSols = [printFormatC.format(sym.N(i[0],dprec), sym.N(i[1], dprec)) for i in filteredSols]
                    else: # real numbers
                        printSols = [printFormat.format(sym.N(i,dprec)) for i in filteredSols]
                        
                    printSols = printSols[col[0]:col[1]]
                    printStr = "{:04d} ".format(n) + " ".join(printSols)
                    if len(printStr)>119: printStr += "\n"
                    print(printStr)
                else:
                    print("{:04d}  ".format(n) + "Nothing to show!")
                    
            except:
                print("For help: class_name.printAllRoots?")

    def parameters(self, eigenvalue, varR, varnR, nmax=41, nstep=10, dprec=400, tol=1e-30):
        """
        One can define his/her own varaiables for "eigenvalue" and "varR" (which is radial dependence).
        varnR: a numerical value which chosen accordingly AIM minimization
        nmax: maximum iteration
        nstep: skip every nstep iteration
        dprec: precision for numeric values
        tol: tolerance value for roots of the AIM equation
        """
        self.eigenvalue = eigenvalue
        self.varR = varR
        self.nmax = nmax
        self.nstep = nstep
        self.dprec = dprec
        self.tol = tol
        
        # create fl0 and fs0 by converting nl0 and ns0 to float with dprec precision
        # this would be help to make calculation faster
        self.varnR = sym.N(varnR, self.dprec)
        self.fl0 = sym.N(self.nl0, self.dprec)
        self.fs0 = sym.N(self.ns0, self.dprec)
        
    def c0(self):
        """
        Improved AIM coefficients for lambda_0.
        """
        # c coefficients
        #*************  
        self.c = [[]]
        self.c_series = se.series(self.fl0.subs({self.varR:self.varR+self.varnR}), x=self.varR, x0=0, n=self.nmax+1)
        self.c[0] = [self.c_series.coeff(self.varR, i).expand() for i in range(self.nmax+1)]

    def d0(self):
        """
        Improved AIM coefficients for s_0.
        """        
        # d coefficients
        #*************
        self.d = [[]]
        self.d_series = se.series(self.fs0.subs({self.varR:self.varR+self.varnR}), x=self.varR, x0=0, n=self.nmax+1)
        self.d[0] = [self.d_series.coeff(self.varR, i).expand() for i in range(self.nmax+1)]

        
    def cndn(self):
        """
        Improved AIM coefficients for lambda's and s's.
        """        
        # all c's and d's
        #*****************
        for n in range(1, self.nmax+1):
            self.c += [[]]
            self.d += [[]]
            for i in range(self.nmax+1 - n):
                # c_n coeffs
                self.c[n] += [
                    ((i+1)*self.c[n-1][i+1]).expand() 
                    + self.d[n-1][i].expand() 
                    + sum([(self.c[0][k]*self.c[n-1][i-k]).expand() for k in range(i+1)])
                ]
                # d_n coeffs
                self.d[n] += [
                    ((i+1)*self.d[n-1][i+1]).expand() 
                    + sum([(self.d[0][k]*self.c[n-1][i-k]).expand() for k in range(i+1)])
                ]
                
                
    # all roots of the quantization equation
    def get_arb_roots(self, showRoots=None, printFormat="{:30.25f}", col=(0,4)):
        """
        Obtain all roots with arb style presentation of numbers
        """
        # define precisions
        ft.ctx.dps = self.dprec
        
        # obtain the solution (or roots)
        self.arb_roots = []
        for n in range(1, self.nmax+1, self.nstep):
            self.quantization = (self.d[n][0]*self.c[n-1][0] - self.d[n-1][0]*self.c[n][0])
            ### ----------------------- current method ----------------------
            expanded_quant = self.quantization.expand()
            dict_quant = expanded_quant.as_coefficients_dict()
            list_quant = [sym.N(expanded_quant.coeff(self.eigenvalue, i), self.dprec) for i in range(len(dict_quant))]
            #
            # TypeError: cannot create arb from type <class 'sympy.core.numbers.Zero'>
            # solved using: ft.arb(10)**-self.dprec
            #
            self.quantCoeffs = [lq if lq!=0 else ft.arb(10)**-self.dprec for lq in list_quant]
                      
            ### create acb type complex polynomials
            self.arb_quantCoeffs = ft.acb_poly(self.quantCoeffs)
            
            allRoots = self.arb_quantCoeffs.roots(tol=self.tol)
            self.arb_roots += [allRoots]
            
            # print roots while solution process continues if it is wanted
            self.printRoots(n, allRoots, showRoots=showRoots, printFormat=printFormat, col=col, dprec=self.dprec)
            
     
    def printAllRoots(self, showRoots=None, printFormat="{:30.25f}", col=(0,4)):
        """
        Just print all chosen roots by user
        Keys:
             r: for real numbers
             i: for complex numbers
             +,-: choose the sign of numbers which will be shown
        Usage: 
              to show negative real roots use the following one, 
              className.printAllRoots(showRoots='-r', printFormat='{:25.20f}')
        """
        for n, nRoots in enumerate(self.arb_roots):
            self.printRoots(1+n*self.nstep, nRoots, showRoots=showRoots, printFormat=printFormat, col=col)

    
    def get_real_neg_roots(self):
        """
        Get real negative roots from "arb_roots" and assign them "real_neg_roots" variable.
        """
        self.real_neg_roots = []
        for sub_list in self.arb_roots:
            self.real_neg_roots += [[i.real.str(radius=False) for i in sub_list if iimag(i)==0 and i.real<0]]

    def get_real_pos_roots(self):
        """
        Get real positive roots from "arb_roots" and assign them "real_pos_roots" variable.
        """
        self.real_pos_roots = []
        for sub_list in self.arb_roots:
            self.real_pos_roots += [[i.real.str(radius=False) for i in sub_list if iimag(i)==0 and i.real>0]]
            
    def get_imag_roots(self):
        """
        Get imaginary roots from "arb_roots" and assign them "imag_roots" variable.        
        """        
        self.imag_roots = []
        for sub_list in self.arb_roots:
            self.imag_roots += [[i.str(radius=False) for i in sub_list if iimag(i)!=0]]

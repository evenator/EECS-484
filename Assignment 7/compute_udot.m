%EDIT THIS FUNCTION
%function to compute dynamics of Hopfield net
function [U_dot,int_Eabc] = compute_udot(V,T,U,J,DT,LAMBDA,int_Eabc,Tabc,Jbias)
    temp=size(V);
    N_CITIES=temp(1);
    N_DAYS=N_CITIES;
    U_dot=0*V;
	% don't alter day 1 or city 1; start at city 1 on day 1
	for X=1:N_CITIES
		for ix=1:N_DAYS
		%current source terms
			% if use wsn's integral-error contribution, then use
			% actual N_CITIES to compute I terms;
			U_dot(X,ix)  = J(X,ix);
			% decay: resistor to gnd; 
			%might try eliminating this contribution...
			U_dot(X,ix) =U_dot(X,ix)- U(X,ix); % corresponds to TAU=1
			%influences of other outputs via Tij
			% do include influence of city 1 on day 1
			for Y=1:N_CITIES
				for jy=1:N_DAYS
					%INCLUDE INFLUENCE OF ALL SYNAPSES IN COMPUTING U_DOT
                end
            end

            

% 		   // the following addition is NOT part of Hopfield's algorithm
% 		   // wsn added in an additional influence that forces
% 		   // the constraints to eventually dominate and enforce
% 		   // a legal solution.  This is done with an "integral error"
% 		   // term based on A, B and C values
% 				// update integral error
				for Y=1:N_CITIES
					for jy=1:N_DAYS
						int_Eabc(X,ix)  = int_Eabc(X,ix)+ Tabc(X,ix,Y,jy)*V(Y,jy)*DT;
                    end
                end
				   	int_Eabc(X,ix)= int_Eabc(X,ix)+Jbias*DT;%/=C*Ncities w/o correction
					U_dot(X,ix) = U_dot(X,ix)+(LAMBDA)*int_Eabc(X,ix); 
        end
    end
                %enforce no change for U(1,1)--insist on city 1 on day 1
            int_Eabc(:,1)=0;
            int_Eabc(1,:)=0;
            U_dot(:,1)=0;
            U_dot(1,:)=0;
    
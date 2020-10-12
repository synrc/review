-ifndef(KOATUU_HRL).
-define(KOATUU_HRL, true).

-include_lib("review/include/erp/catalogs/dict.hrl").

-record (locality, {id, 
					koatuu_id=[],
                    prev=[], 
                    next=[], 
                    name = [],
                    type =[] :: #dict{},
                    l1_id =[],
                    l2_id=[],
                    district =[],
                    main_city = [],
                    village_council = []
                    }).

-define(LOCALITY_TYPES, [
	{region, <<"Область"/utf8>>}, 
	{capital, <<"Столиця"/utf8>>}, 
	{special_city, <<"Місто, що має спеціальний статус"/utf8>>},
	{region_city, <<"Місто обласного підпорядкування"/utf8>>}, 
	{district, <<"Район області"/utf8>>}, 
	{city_district, <<"Район у місті, що має спеціальний статус"/utf8>>},
	{district_city, <<"Місто районного підпорядкування"/utf8>>}, 
	{region_city_district, <<"Район у місті обласного підпорядкування"/utf8>>}, 
	{city, <<"Місто"/utf8>>},
	{town, <<"Селище міського типу"/utf8>>}, 
	{village, <<"Село"/utf8>>}, 
	{settlement, <<"Селище"/utf8>>}]).

-define(FEED_LOCALITY_TYPES, "/review/locality_types").

-define(REGIONS, "/review/regions").
%---------------------
-define(TYPE_1(X),
	 case X of
		  <<"Р"/utf8>> -> region_city_district;
		  <<"М"/utf8>> -> city;
		  <<"Т"/utf8>> -> town;
		  <<"С"/utf8>> -> village;
		  <<"Щ"/utf8>> -> settlement;
		  _ -> error
	 end).

-define(TYPE_2(X),
 	case X of
  		<<"Р"/utf8>> -> region_city_district;
  		<<"М"/utf8>> -> district_city;
  		<<"Т"/utf8>> -> town;
  		<<"С"/utf8>> -> village;
  		<<"Щ"/utf8>> -> settlement;
  		<<"">> -> village_council;
  		_ -> error
	end).

-endif.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cakramedic/LocalBindings.dart';
import 'package:cakramedic/providers/Login.dart';
import 'package:cakramedic/providers/Profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../style/theme.dart' as Theme;

class widget_profile extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<widget_profile>
    with SingleTickerProviderStateMixin {
  String id;
  bool _saving = false;
  bool _status = true;
  String _imgString = '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';
  String _noImageString ='iVBORw0KGgoAAAANSUhEUgAAASwAAAH0CAYAAACHEBA3AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAALJ5JREFUeNrsnQuQFdd558/wBj3gGoQUPcZDGCRjKViyWGQZEoq1LNmyYkLFWVU5TtauOFlnU3Y2W5vU+lXrZLVel5M4lcduXlZie23tKvGCcYi8YMkSsWRsDJbEgpFgFNAgLAQrX2QhxEMw+/2n+8p3ek7f6b63+05339+v6iuJefXtr0//z3e+851z+kZGRhwAQBmYggsAAMECAECwAADBAgBAsAAAECwAQLAAABAsAAAECwAQLAAABAsAAMECAAQLAADBAgBAsAAAwQIAQLAAABAsAECwAAAQLAAABAsAECwAAAQLAADBAgAECwAAwQIAQLAAAMECAECwAADBAgBAsAAAECwAQLAAABAsAAAECwAQLAAABAsAAMECAAQLAADBAgBAsAAAwQIAQLAAABAsAECwAAAQLAAABAsAECwAAAQLAADBAgAECwAAwQIAQLAAAMECAECwAAAQLABAsAAAECwAQLAAABAsAAAECwAQLAAABAsAAMECAAQLAADBAgBAsAAAwQIAQLAAABAsAECwAAAQLAAABAsAECwAAAQLAADBAgAECwAAwQIAQLAAAMECAECwAAAQLABAsAAAECwAAAQLABAsAAAECwAQLAAABAsAIEumbdiwAS9Amg5ujtnlZrPNTpj9yOxls1fMzpmdD02M4DJoxbp169IJFi6DCegLReoNZu9XGzOb1/R9idYxs7NmdbNHzXaYDZkdN3ve7CWzU+HPnG8SMgQNECzIhBlmV5m9x+yXzBbH/NyFoTW4KfJ9RV7Pme0xezL8/2fM9psNh2J2OhSzc6GIIWSAYEGiId9cs9vNPmC2KqM2dkVot0a+d9LsRbMXzA6Z7TL7ttn/Df/9cihiAAgWvDrkUz7qp8zeG0ZUF3bp2nNCu9TsarO3NH1PgvU/zf6H2T+H4kXkRY8KPcr0UCQ+ZbYvjGw+0EWxmggNR3/HbKfZPWZvM6vRZomwoDeHfBKDZSX4zMqlrQ3tgNlfmt1rdtgFeS8gwoKKDfk07LrF7GtmPzT7YknEKsqiMCLcHw4VbwyHs308ZgQLyj/kWxy+4JqZ+7obn/Qu88jgTheUT2wx+zmzBWZTeewMCaE86IVVAltlCL/hgjxQ1VkVmmq+/srsT82OuKCcAoiwoGDDPYnUa8zebrbRBbNrn+oRsWpGxazKyynPpdnFN5vNZLiIYEExntsFZjeb/bXZU2b3mb2DZzo6aniX2SNm210wuzgH4WJICJMTUc03+xWzX3Xx1ecQsCwU8u+b/QezB8zO4BYiLOjOs1Jh5WPhkA+xSs7rQ+H6kgsWbhNtIViQ83PSMGezC5a4QHvIh/9k9jOMLhAsyAcl1d/ngmJJnlfnKDJ9yOzTLiiiJdpCsCBDsXqv2WdxReb8VihcS3gPECzIRqzeg1jlyvUuWKuooeIs3IFgQftipVnAz+GK3LkwHG6rPORShogIFqRjWihWf44ruoqi2d0uqNtiiQ+CBQnQzgS/jlhNGlqPqPKH/2h2Me5AsCAe7TrwcbM/wRWTzl1m3zBbSrSFYMF4lEf5gtnHcEVh0NY12rL5Qy5YkwgIFrhg4bLWvb0LVxQO5RM/44KZ2st5XxCsXkc5E+3ptAxXFBol5L9ndpsL8oyAYPWkWCmyWoQrSoFKHpSQ/+MwKqb8AcHqObG6GleUDh3UoV0f3uhIyCNYPYAS7FsRq1KjCvmHzH7esYgawaowaty/74LtTqD8HY92Nv1Z3iMEq4oo53FnOKSA6rw/nw07IHJaCFal+EnH2sAqogS8NgZciCsQrKqgwsN7HfmOqqKylD9zwd7xgGCVfij471xQOQ3VRYW/H3TBeZCAYJWWa12wBztUH61BfBvvFYJVVnQU1wO4oWfQkP9vzAZxBYJVNlRU+BeOZGyvoaJgLWSv4QoEq0zc6oI1aNB73GT2SUcSHsEqCZeY3YMbehrV233QMTOMYBUclTB8zWweruh5FGW9lfcMwSoqKmHQ9rqUMEDj/dLhFosclfAIVgFRNfsncAM0oZO6VQlPEh7BKhQ61+7ruAE8KAn/Xxyb/yFYBRoK/pFjMz6IR0n4X+CdQ7CKwM84dmGAifmc2b9w5LMQrElE1ez/BzdAAlTioD20yGchWJPmv+0uyF8BJEFpA+Wz2F4Zweo6H3bsHgrpUfqALbIRrK6ic+ruwg3QJu915LIQrC767VHcAB1wB8NCBKtbaOkNuzBAJyiVwPItBCt33u6CnRgAOuVaXIBg5YlC+PtwA2TEWkceC8HKkdm4ADLkXY48FoKVI+dxAWTIVWYX4wYEC8GCsnATLkCwECwoCyyIRrAQLCgNmnGeiRsQrDwYwQWQMdrg71LcgGABlIWVjvIGBIsIC0qCToumvAHByoUzuAAyZo1jiyIEKydY9AxZozzW5bgBwcqDE7gAcuCncQGClQfncAHkwDreRwQrD87iAsgBzRSSx0KwMucVXAA5oL2x2GMNwSLCgtKwAhcgWFmiOixyWJAXb8IFCBZAWWC/NQQrc17EBZATz+ACBCtrXsYFkBO7cAGClSWsJYQ8eR4XIFhZQ1kD5MVLuADBolFBWSDdgGARYUFpeAEXIFgIFpSBo44ZaAQrB0iMQh581+w0bkCwsuZpXAA5sM9xyAmClQOHcAHkAJM5CFYuHMcFkAPKYVHnh2BlznlCd8gBqtwRrFxgtwbIg6dwAYKVV4QFkCVKMzD7jGARYUFpOkGOj0OwcmGEKAtyECwS7ggWQ0IoBT9EsBAsgLKwGcFCsPAblIUHcQEvXl6Qw4KsGcYFCFZeIFaQNc/hAgQrzwgLICtOmB3DDQgWQBnY6qjBQrByjrAYFkJWbCBqR7DyRJXuddwAGfFVXIBg5Ym2SP4mboAM+L4LikYBwcoVNvGDLLjHsTYVwcoZ5RvYHRKyYBMuQLAAysApF+zjDghW7nDUF2QRXZ3CDQgWQBn4G0c5A4LVBfrM5uIG6JDv4gIEqxvMMHszboAO0NpBavkQrK6wzOwm3AAd8HlHOQOC1QVmmf0BboAOuQcXIFh5o9zVO81W4QroAM0M7scNCFbezDe7GzdAh2x2lDMgWF2Irj5idiGugA75S8duHwhWzsw0+0XcAB0iofoObkCw8maB2ULcAB2iwyZewA0IVt4sxgWQAX/rKGdAsLrAm3ABZMDjuADB6oaPrsMNkAFrzWq8dwhWnmiG8CrcABlwl9kPXFDpPhV3IFh5oIbFYmfICq2WeI/ZT+AKBCsPppnNwQ2QMZTJIFi59YiUNEDWvBUXIFh5oOr2ebgBMuYnef8QrDyo4QLIgUvC6B0QrMyHhAB5RO6kGhCszLkIF0BO3OCCshlAsDLjtbgAcuKNCBaClSVqTCtxA+QYYVFAimBl6p8bcQPkxM1ms3EDgpVlhMUsIeTFa8wuxg0IVlbooMvncQPkyKW4AMHKCu0Q+W3cADlyvSPxjmBlGGF9FTdAjrwJwUKwsoQ9uCFPfor3EMHKEu3B/X3cADkxYDYDNyBYWaE9uL+AGyAnlHRn+ReClSn34gLIEfZbQ7Ay5Vmzp3AD5MArZi/hBgQrS846ZgshH75h9iJuQLCy5DzDQsiJj4RRFiBYmfIEDQsy5otmj+EGBCsPTphtxg2QIR91nASNYOU4LLwbN0BG6Nj6Q7gBwcoLLdP5ltkZXAEZ8OGwTQGClRt1s224ATpEEzhHcQOClTdnw1AeoBN+k+gKwerWsPBh3AAd8GmiKwSrmzznSJZCexw2+z2iKwSrm7xs9hXcAG3wq45lOAhWl1F5A8t0IC0HzO7HDQhWt1E4/7jZD3EFpODXXDBpAwhW19Gmfl/HDZCQXWYP4gYEa7J4BcGCFPyiYwkOgjWJKI/1rfC/AK3YabYHNyBYk82wC3ZwAGjFux1lDAhWAThldg9ugBY8YDaEGxCsIqCcxOddUEgKEEV5zl8mbYBgFQnt9f4+F+yVBdDMp8L2AQhWoaKsLWYrzDbiDmiKrn7fkbtCsAoqWnvN7jR7pwtyW9DbfMzsR7gBwSoyp83uc8GsEPQuJ83+CDcgWGWJtrTv+wFc0bMop8mutAhWadCQkN0cepPjZl/GDQhWmVCilWU7vcktjjIGBKuEgrWHhttzaHO+nbgBwSojz5sdww09g8oYluAGBKusaMbwcdzQM0isXsYNCFZZ0XDwn3BDT6D6u4O4AcEqM8pjfQ83VHoIqBnBD5n9Pe7oHtNwQW6CtQ83VA6VrLwxjKjOhsIFRFiVQEn3/4cbKsVHXLAM62XECsGqGmrU38ENleKLuADBqipaprMNN1QG7XtWxw0IVlUZIcKqFP/AMBDBqrpgKfFOxXs1+DNcgGBVHSXd2bmhGuzFBQhW1VHFOwuhy4/yV2wZg2BVHg0H78MNpeejuADB6gWUx9rpyGOVnQ24AMHqFZTHYueG8qITkY7jBgSrV9ASjm/jhtLyHSJkBKvXhoUskC0vf4gLEKxegwirvHwTFyBYvQbH2ZcT7c5wEjcgWL2GFkKz3Uz50JFt5K8QrJ5Djf4fcUPpuBsXIFi9iBLvG3FD6XgQFyBYvcouRz6kTBwyewk3IFi9ygtm9+CG0vD5MDIGBKsnUR7rdx1J3LLwOVyAYPU6PzD7b7ihFJ3LIdyAYPEiOPdp3FB4lG88ixsQLHDuWcdhBkXnC478FYIFo+hwik/ghkJDzRyCBU08bfa3uKGwUH6CYEETrxBlFRryVwgWRDhMlFVYKD1BsCACuaxiPxtAsCDCM2Z/gRsQLECwyjL0+Dhu4L0AHkxZeN5RTFrEjgQQLPCgAsU/wA2FeyaAYEEMOkaKI+2Lwyu4AMGC1j36C7ihEDyHYCFY0JqpZnNxQ2EECxAsaME0s0twQyFQlTtJdwQLWqDo6kLcAIBglQGiq2LRhwsQLIinHxcUBuUTKWtAsKDFM7gdNxBhAYJVhhfjp80+gCsAEKyis8TsIdxQKK40m40bECwYixLt9+GGwrHA7N0uyGUBggVGzeyvzRbjikKio9jeyfuBYIFzF7hgp9G1uKLQ78Xfmd3GO4Jg9TLKjdyNWJUCrT74KqKFYPXyC/ARsztxRelE6x28KwhWL6HyhbeafQxXlFa0PuxIxCNYPcJVZvfghlJzl9mXzGbiCgSryihv9d/N5uGK0qPh/P82m4UrEKyq+lc1Pe/AFZVBz/LLjuJSBKtiKG/1+jC6guqJlkpTZuAKBKsqzDe7l0Zd6eHhb/MOIVhVQCL1X8MIC6qLEvG3OXZ3QLBK7tOfM3s/rugJvmJ2M6KFYJWVy83+FDf0VDT9gNm1uALBKhtzXLD0ZiGu6ClU5rDV7FJcgWCVBVVBf9DsVlzRk7zGbGPYaQGCVWiUv1hl9klc0dPcZPbHjplhBKvgYqWdQ7+CP8EFky2fcsEaRECwCidWrzX7pmPpDfyY3zL7qGOxNIJVMLSo+duOJDuM5xNmH+IdQ7CKgsoXtjtmhiCez7hgGQ81WgjWpKIDJB5GrCAB/ytMGwCCNSksCMVqEa6ABMwJ28uVuALB6jY67eZ7ZlfjCkjBFWZPmt3imD1EsLrExS5IsF+FK6DNSOvrZnvM1oX/JreFYOXW2L5LZAUZoDa03uwlF+yVdjnvIYKVJapafhSxghz4gNlhs2+YrXZUyCNYGYjVtxAryBmJ1UNmz4UidiHDRQSr3WHgjbgCuoRWS/x5KFxfMFvMO4pgJUHHyT9itgxXwCR1lu8xGzLb6UjSI1gtmBsOA6/HFVAA1A6VpH/B7A9dULTcs+8tgjUWVa4/SmQFBUT1W1pUfdQFJ1H3ZJIewQrQg3+72ROOCnYoPlqf+JDZP7sgST+3V4aLvSxYuvcFYa+lB3+fY4sYKBeqoFeS/rjZX7lg+c/Uqr+0vYR6ISXUtUTia2bHXLCi/graPpQcbRx4yOw7LkjSX1DFqKtXBEu9zoALtq894oIlEuy9DlVEZThK0j9j9nuuYpX0VRasKeHY/l+7YMHyARccEnEhbRp6AKU3PuZ+XEn/ZrPZZY+6qrZyXA9jutnysHd5C+0WYHRG8ZFQvP7O7F6z3WYvm50nwpqcIV+/C+pUng0fDmIFMBblajXJpF1HjoRDx3XhsHFmGaKvMkdYjQT6WrPfdcEyBgBIxoXhu7M2/PcPXZDblYipcFr1XmfNRhCsztA4fIXZb7ugdopaMoDO0UGwd4bm3I8LVL9o9pjZCbNzCFbyId9PuCBp/m8diXOAvNFJUO8P7ZQLNh78e7N/dEHdor7W9fxXkQVLQz7t8vnL4bibCnSAyWGWC8olZDok9owLTozaZPZlsx+EApb78LFow6m+cMinWY0NLqjg/RPECqBQaCnbqlC8hsLhovJf/8oFCfzpLqcE/rQCOUBJ8183ex9DPoBSocDnLe7HM/Mqn1DyXkec7XLBdtCZRF+TKViNvNQvmP2GY5YPoCqofOKDoYnvm91j9qVw+HimLENChYnaiOxnzR5wwdqnzyBWAJXm9WZ3uWC1yYsuWLDd1kLtvvXr13fjA08LP+CvuGA7jAU8Q4CeZ1cYsPyD2fF169ZNOOuYp2ApmtJ6prea/Y5jb3QAiEflEv/ZBTVfZ0y8RrolWJohGDT7T2Y/7zjpFgCSo4JVVQZ81uxYNOrKSrA0FtX2wr/kgkQb+0sBQCdIqLRn3SddsGzoabNTnUQ/U8IhnzbD+7Dj0AYAyA7pyztC064SW83uTitYykupZmqJ2b93QUkCNVMAkCcqJn+bLKlgNWqmtBneu10wTQkA0FWmTRBNSdm0U6ES6KtwFwAUTbAa0dS/Mfs1F6zaBgAojGA1KtD/pdlvOnbrBICCCpZWV3/cBfveUDMFAIUWrMO4AQDKANsLAwCCBQCAYAEAggUAgGABACBYAIBgAQAgWAAACBYA9AiFXIqzdu3a4SlTpvRHv37UeOSRRxbmeZ0tW7a4l156qXIP+sYbbzzZ398/p/lrw8PDJ3fu3DmH1wCIsHJgoXHFFey+DIBglYTly5cPT58+nScHgGCV4APbEO6aa64Z4dEBIFilYMmSJX3z5s3j6QEgWOVg1apVQzw+AASrFEyfPn3w6quv5gkCIFjF4/z588PRr1177bX1Cy64gKcIgGAVi8cff1z1UvXIl2vXX3/9UR4jQG9Qmj3cT5486fbs2VOzqGrM1xu1WYcPT+5OzwMDA27GjBmjUZ+ENBod7t27t//48eMqfq1UA1KEK//b8HxIw/Tm7+3fv3/kxIkTfQcPHoz9fU2e2CN0S5cuHVfEq0LhY8eOLdy3b1+mn/Wiiy4aV0TbwNrY6H/VnrIqIG51j/LRmTNn+rK6xygqAVq0aJG75JJLjupdiXy7rndK9znZ70/lBEvoofpeDNVmWdvuP3v2bNc/k/JoERGtjQtjrZE2fkbipWix1UtcFDz35h555JFR0dWLsGzZsuYXfzD6+5rN1X+vu+66oYcffnhQgt0sHjfffPNBE4+B8EvjVjYsDBj9DI8++qhr12f6G/ZZm68VW93fuF/919rTkF13sN2XOck9Nnykjs6uVWvc4y233NL8e6NCmkbUdG2NPppEyrdCpDkAGHN9hoQZoYbvE4Ru12apQdxxxx1D0Rd6QofbZ73hhhtGG2RZC2B177fffvtwXJTi6eUH16xZU2+UougduvXWW13zCzkR8lk7kywrV648apbqWs2fe8WKFaN/I+3vKpJLeY813aOWUHX6fBrX9kRUE15fbbrIeeHSCZZ6aYXRvp6qW7VZuo41iHo00kuDGrJe+rJNGsyZM0di613rOdELoVIUvUMSkHZQ55DmHZTQpHxp4yK0hRYlJu4QlR6Q0LWDOoFOREui3u61GyKttl3UOsdSnkP45JNP9i1evHjcS6MXYtOmTYN5XltR0erVq4d94b1yLjZ8WBgNq9WIrCEejPa2+vx6+e+///7+siy4Vi/cfO8vvvjiwb179w40D5v0wmoYGBV0/TsqVo38XvNwRyK+aNGikcZwqRl7GRM9Y0UZPrFqXO/AgQMumkLQ79RqNe919TUNhSfKQepFD33kzY9Fc2O6pvlrjLCGketAO2Lli/h9Pm48J7u+T9Rrioi3bNlSK1q7LGUdlhratm3b+n29Q961WfbCHPVEF3XldrSThC8HoIZiojSwfft27xBReY4yPgfdj+4rmuORDzZv3jyoHFCr31ekvHHjxnEvkl6S3bt39z344IPeCCBJ77906dKDvg6lcT1fvlP3oetqxw7fZ7f3eiRhZzYGibqJ7Gg7iAqArql2o/bjxs+Cp4r6fWIV5+PGc2px7VoR22VpC0fV02l7FM+wIbfaLPVIvl7bXqxaktm/sHF6h4f622VC99EqGS1BUMK6lVhJHCYa/vue8USjPAlHNJpVlJF0ayKJij3TQc/zf6rV72k2LtqZSfgk6hNNCKn9qB21+zx8Kz8U0U3k41bXlg8zGFEjWA127do1x3WxNusNb3jDsK9RNM9+JWkcvhychlBl8btEJIlAt/iZuob1Sa515MiROZ4XqWWOx4Z1476mIVGae5RoRaOsqVOnzmglkmFJyxh8k0StBLpRVpG2I40OvxXVpZlVjMsNa3YVwcpwaKipWE8PnPm+WeppfENB5ULaycFFhTbpUKcIPPHEE3OSPh/fCgV7MeYlLUHx5VBMkI5OFGH5Xsi0nDp1alp0+N4qZ+YiJS0agqa9btieUg0NBwcHx4nKtm3bBtpsl+OirCLNZpcy6R4dh+uBRYcAqs2yIUt/VtcJ8xd9kUhjZju1X/oda8tno+G2/t3Oi9XlTmLIRKSjiY16vd6XxldRZs2a9cpEQ+8NGzZ0fK8TXSciWBLRhZG2ubCdtiFBX7JkSaKfV/oj2vYVXdkzGmizXY5LwuufRSksrcSe7r7eRL1hlgl4a0DHkwxXkqIK7ujXVI1cdF8/++yzl3f6NzoV5VZDsywj6jRlK/bz01MMiTMTdN9IwjrSgSzbpWZOGRJmiIYNvrG/Zk2ySMCHIXEtqwYZ97sLFiw4VXRfW+89J4vnVVTUXtTRrVy5sp7md5xnOVa7Ky/SCLqvk+ukQ/A9m7lz5x5jSJgxSjD61mppalazNJ38bV8SV0Mjs8EsG0YbxZhd58yZM6VvK4qemvOFvvWfvg5qAsGKPt/z3RB0a5s/ig5FO+kQfGI3e/bsk0V5dpURrHBo2B8tTGyUDHSyRkrV3Z6w/eJOPmtc76vGX8VTeyZboJSD9BWEphWnFO2jo3oARWhJOjCL/udHv6ZlORlHnYUZiVVKsBq1WdE1bjfccEP98OHDtXZDdO3CEOXUqVMXIgXFJrL4uK+b1z59+vTsLl2q1kvPtHIHqao2yzOVXtPOAlleJ4tcDuQbVaVdYK0ZMuVCtTOEZhl9JRkphs59PAUirERDrR07dvRHF4Aq6jp06FDh96OqQo5oslF+qtUCa+Uf9+3bN5p/jKzty6ys26LykU6iujLkMxGsjFAj9NWT2PBgWOuqsrhGWG3ddpQVN3s5GXt6VY1wmcq4CRGlCxSBdzJZkpSZM2e+3G776LRQM4satAiFEc8pVW20jz32mMSqHu212qnN8kU9s2bNOtHJ5/MJ1kSLhSHZUNBXP6Vh3s6dO+fk0SHEFLe23T58s9Jx+IatVT5ouLKCFdZmjXvy7dRmaXvmKJ3WTPmW4XQ68wj+HRUUbee5k6ZvVreT9pFmida5c+fOJI3eEayCE24jMi5qSbtthgmJN8fQSU/mK/jzVRlDOi677LKno19rZ4lM4xkn+Tlf7ZJ+t13h0DbgSX/W7m2xL8qsKtOq3oC1Wn7NmjVjvpZ2OxeF/BK+6FBD24m0c3iAhC7LpRwwJrqYkiQCyjLKaQzno+1Dy2bSto+0S4J8y3jUGdp121ItvRfRDQjT7idPhNUBcdtmqDbLesGLOunJ0vSE0YbsIvUzavBFX/jcSyxevDhVGUxj1rEZrbxIG4Wn3c7F18lpsqnd6N+380OROtIpvdD4tG2GrzbLpSi6O3DgQJ8nUhpsZxsb375avgYP6fEtiUk7NFN0lfSAjab24R0WpjkcRRNCaQ/LUPTv2+SwnUNZwiPQxlxfOz8UqSPtCcFq1GZ1+CJ4G4a2sUnzQqhRRnMjEtN29tWC8Rw5cuS1nkgncdSiZ+nb5rhd4dByoCQHWOhn0p7A1MC3P1naQ1n0sytWrBiXrN21a9dAkZ7vlF5pyKrN8jWoNhrGuFIJHSSRpHHEHRKgcwqpv8oGG754N6FLUs6i/I2q49st2oxZZTEqHjo+K/oZNGzT19auXTscWeeYagM/daa+tIcOkkiSgNfP6GedZwPCouVVp/VSY1aDslC/7tpcf9UolYiKjhq4EvtqNEqCRjc7izs1p9Eo2p3FAn9OR8OYqK/1zPQMFDE0v4SNnRviTuyOilerU8bV6WzdurXf9/IrfaDPEBNFjbnG9u3ba2mP6tLe7Sa40cR/TRX/rU5zajoRety92+coXLV9TwlWY0vluGOYktCYLfE1vBa7AYx24J7PM2SNgtxVxtjwfyA6M9yItFos2RnzwqrQdMaMGf3R59wsJDpdJzoDqXyPjsey6w+1c25l4yiwdtBJRbfddtu46zZO0I5p977Osi7hLWLUP6XXGrN6GfXAnfwNiVY7hwVEIyudr8dQMHskGr7TiZIQnq4z2k7aFQ6JmJ5tyjZS17FpalvtzvCpLUm0OhnHqROV4BZ1xnpaLzZobanc6Z5BalhqF8uXLz+YZmZHL4QmABSiIy35Dg0lPFo/mjAnVddw355rfzQ3NEHk3LKNyMLZv5O+mUeJmpZ+mUC+GuH5tjNKuiheoqXjzMJ6qjTpj8b9Fzri71u/fv0IzbszNLOk3EarPJWq2PUSUWvVffTyzp8/3ycYoy9pKBixvx9Olox5+ZsWUmf+eTV8iw5dFX21E/GpXap9xuXodPyZhLkoh0wgWAAlwzeb7MuX9SJTaB4AxcKzzrSOWAVMwwUA+URFyn8lOSq+Gd86U51/iYeJsAAywxcB6SzLtDN+K1asUHQ1Jtd06NAhtuNGsACyI6wkiFao11avXn0w6d9YuXLluF1yVYLDLh4IFkCmaLbQt2GkZo219EZDRt+aU+mTvrdu3Tq30LOORkWwePfHkMMCyIiw5mpcpbnqwFosy4lF1faUwRBhAeSGKs07XUkhVHeV57bORFgAMDo0vP/++0d3tNW+Z2l3flBBqnYFoYwBwQLoGoqOzPobu0E07YoQpd7IfYUL65kRRLAAJgfN8Mla7LFew0vJIYcFAAgWAACCBQAIFgAAggUAgGABAIIFAIBgAQAgWACAYAEAIFgAAAgWACBYAAAIFgBAGkq/vcwtt9wSe9qyjuzmEU+M74gqbc8bt+NleAx64p+fLLSH+q233jrma9oNVBvs5X3tsviICKvLDdInVkKbpaU9YgkAEKzcuOKKK1p+f9GiRTxhAASrGCxdunR4gqHOEI8YAMGadLQ99kQb/Ou4Jd9ZcABQTkqbdL/qqqtOugQb9mvYGG7uDzHIP/gIiLByQsn0/v7+05Ev1/fv3z+SdtgIAAhWroTJ9jGnjQwPD8985pln+sbdoA0b/acrAQCC1QUGBwcPRr926NChOTrW++zZs0Mxw0cAKDmly2H5aq/Onz8/fPTo0dEE/L59+wajRZAaPu7cubO0B1TqnhVV2n2ftHvx3seePXtG/3v48GFXllODi3JfKpyN+Qyjh5zqurr+ZKEUiEp0Yg5jLcRnRLBaDwfHsHfv3ldnC/XQooKl4aN+L+kD9VV+q2Fs2rSppqPI22HlypXjGttElc/68WXLljVX8seKbuPz6r+KMu1vD3Zyv3lWZXfrvlLet+8z1BrfV6e4Y8eO/m6KggT9+uuvb243C1t9RrVR80+tytX0pRsS+pLoOlm3gXoaLb+I/szAwMDRpNdo/nvNDaPdXJh6SF/P2KrxS+DMYiv5J7je4IoVK0b/RtGeXxHuS89DS7o8nVL8izJlSr+ufd111410q2PWsqKF6RpdTcuB7rjjjqGqlvOUSrB8tVfqdZW7amZ4eHjA87uJl+rE5cIuu+yyk+02viiaJIiL1nzRWJv+WtitF6zdKLPb9zVr1qxXbrvttqF2BFMsWbKk78Ybb8w1J6rIT+LYgSAPmtjV582bx5BwMvHVXilnFf25AwcO+IZ0o3mApPVGWebCTLCORsN5TRLEiZvvpdaQRENf3VtU6PQ7tVptRC+T7wVTxBgTNXZ1KF+E+9LLHP2aIvKhoaGB5qGUXvYrr7zSe23luk6fPj2ye/fuvjzEytd2G36Ktl8tslb78vi2tmbNmvqWLVtqZclpVirCiqm9GhWnKGr4Rz0tOc1SHd/fbeTCOh0OhpMEcUPeg54h6tGNGzeONlZfVKahpV4ea5zeyNAuP+lRVkHvq759+3an3RuieR9F2br2gw8+OPpzPsHMetglkfSJleoLG36Kos+tXUnMfJ+zdvPNN1cqoVUawfLVXqnBxw2rrLEv9PWuSRtZnOipx+90OPjUU09dFSduvhnQpNvkqCe1F2xcBGG98FOT3dkU8L7q9jdrEyXRJVz6Od/3lBDP0k+rVq0aJ8qaJU0Syamp+j6n/F6lOsTSCJav9sp6l9gnETbEehIBafE3Fnp61uOdfm5fgWsohuO+1jwDmvTljkYjU6dOnTGZz66I92WRVS2a+2wlWo3yimguLasoS0O76HBVQ9U0S6b0OX2rPTQji2B1kZh9r+qt8hdhhHTWMzRJvFQnRvQSzxb6IgvfJEHzz/saYVpOnTo1Jjc50SLxbkRYRbovCUHa8oQwRdBRB5i2Y9u2bdtA2r/z5JNP9vmirKrsDVeKpHvaWbbmCCwqLo2lOkmStfr7uk5/f/+43In9/oRhum8/Lt8kQbNAbtiwoWN/aSasSM+vaPelBHva34lrCyrmtGfa0ZjL1yFLVC2qbOtzKpURbfj6ZxUKS0sRYfmiorhZtiTDwjTJWt91Fi9efCjJ71rjPhjTU+eGGqZvJqzsZHlf7b64R44cGdcWFixYcCqnDnmg3b937NixhZ5h+UgV2sGUMjTUaOjfapbNF4lFv5YmDxVepx6N0iaqcfENB1tNEmQxbNaU+MqVK+tVEqqs70ttp91n4BvGqi10OtxSlJbFkLmBr4xh7ty5xxgSdgFf7VXcLFtchBQN413KpTr79++fZyI35muq0bFG1ZdmONhqkiCpeDcL5bXXXquXOJrRrpUxeurWfdnLfD5LIRAzZsxwnXREFv38yEXq9DqpnfKJ3ezZsyuxAUChBaup9mqMYMXNsk0QIY1p8Fqq45sF9KHrRQVLU+q7d++OHaKENV/N39dSnFraF1nDV1/xYlnFabLvq16vd9RpKEKLRvyKAjsRGGvn86Nfi572k0GkWokj/QotWL7aK7FmzZrUnZjnpRldqpOkZ2ws1WnOoej/FRX4ejM14Gi+RVFammGQCv7CIWWfqwhVva8MqOGCZBRadX1TvVmS5lQd3+xeXHmDL4maNCrU31Tvmmatm3JjqhPSDguajVMUUMSoqor3BURYr/bG7S5QTYpm8UyIEl3Dt22Nhn0+IYsOB/WiWSQ2Yc2QIjbtZBCHorzG9SL7QxW6lLmq99XgzJkzKEmvC5ZFPyN5DxskiEnzD41ta5pF1Dcs9A0Hk1Z1h0szxgng8PDwyV27ds2xF7uU5QpFuq9Zs2adcAkOL4kdkkyZcpFHcDP/nFnUrUX7ZwQrR8LSgzFj+042lZOw+HJfaU7VUcFh9PhxDXWaBcs3HEwyGxlXZxTec2l3Sy3afflm5JISli/UfJ1ZJ/gS+Unzq71GIXNYMcn2eieVunF7XHW6VCe6A0T032HFcpIXe8SXwyn77pFFuy/fjFyaNIVvONvpZzp37tyZJNeCggqWb3fQJEtxJsKXb0pzqo5vfWLzDhCK4qLRRNJlIJdddtnT0a+1W7c12WsHC35ftXY3tvO1E7uXxZ1+IN/f4KSnkgwJY7YTTrQUJ0mE5NtvKOnawMbLFv14jWGl52Mnrr3y1cm0M9Qo2i6TRbyv6DA+KeFSqzEdUL1e7zjP6vsbnaxR1M4P0dSFZlurcFhu4SIsX6lBmqU4rYjb7z3NUh3fsLCxZjA6HMwiKkzL4sWLK3mkWZb3lWYjx+YhWtodQ5Li+xtptvSO4isHmuwdZysrWL7GlGYpzkTELCpNtZNotAi0sUladDiYJir0LRlJm8dQFBJ3XNZkUcT70nNKuy3M6173upN5pCkaqQbNmEa/fs0116ResBwemzamjauT7mRtIoLVomH6ZpTSLMWZiLjdEtKcquP7PNHFuWmjwiNHjrw2+jXftsKtIoDVq1cXrrCyqPe1fPny4aTCGSeYTzzxRGYi6vtbWrqUZiisn12xYsW4ReK7du0aqEqkXSjB0oJiT+8zlGXvELf1cdpTdTxV17VOokJfDk09pXYqSJKzUBV5kZLtRb8v/c01a9ZMeByWImcd5uCJskeyPNxBf8u3W6iunSQB3/Q5x20jXpXhYOEEy5dLarXhXbvELXpOM0yYqBg0bVSoRuXLr2mSQGfoRRut/q2Xft26dfVogtW3hCWrnTHbyc8U9b7C47BGzxr0fQ4d5xVW6Nein8O3s2enaO92T5lETZ9BR6RJwD0plFfPevR9zu3bt1dqurEws4RxC53z2PBOiXN7Gcb1RkpWGgNJ/0bcQZxhVJhaaHfs2DHgK25VRNJiacu44toZM2b0Rz9b8zl3OoWmm0c/Fem+lCtStXvzVK+GXtHdOEJ8Q7761q1b+/OaTNm8efOgzk2MpkYWBoyb/Wt8u9ufs+cjLF8OST1zHg6P2++9sVQnaQjvixw6iQo11AyPa0pNeArN6EqAom2FW7T70mk9cc9uos+ik2nyTGCrbUq0OhnHqcPUeYRVSbQXTrDiaq/a2Xs7KXHFi2mGGHHb2HYSFaqd6gVNsTNBXTU2Oreu0cbj8iGTnMsq1H3pLELfSTitIrP77ruvvxsiINGSqCqqdJ4tvify2aZNmwardHhqM33r168fcVBIlLOYP3/+Sc8MlRpmTbsEtFriEp4iPGbo27TgmPsKO0vV/qmWzlcOoE7Jdyp1t9Mlivx9O7E2ToSWQFXhkAkECwAYEgIAIFgAAAgWACBYAAAIFgAAggUACBYAAIIFAIBgAQCCBQCAYAEAggUAgGABACBYAIBgAQAgWAAACBYAIFgAAAgWAACCBQAIFgAAggUAgGABAIIFAIBgAQAgWACAYAEAIFgAAAgWAFSFaWbHcQMAlIH/L8AAdxPOmuXgHx0AAAAASUVORK5CYII=';

  final FocusNode myFocusNode = FocusNode();
  TextEditingController inputEmailController = new TextEditingController();
  TextEditingController inputNamaController = new TextEditingController();
  TextEditingController inputNoTelpController = new TextEditingController();
  TextEditingController inputPasswordController = new TextEditingController();
  TextEditingController inputPinController = new TextEditingController();
  TextEditingController inputAlamatController = new TextEditingController();

  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeNama = FocusNode();
  final FocusNode myFocusNodeNoTelp = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodePin = FocusNode();
  final FocusNode myFocusNodeAlamat = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);

    if (image == null) {
      print('test');
    } else {
      String base64Image = base64Encode(image.readAsBytesSync());
//      print('foto camera $base64Image');
      setState(() {
        _imgString = base64Image;
      });
    }
  }

  void getUserData() async {
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    setState(() {
      id = json.decode(dataSession)['data']['id'];
      inputEmailController.text = json.decode(dataSession)['data']['akunpasien_email'];
      inputAlamatController.text = json.decode(dataSession)['data']['akunpasien_email'];
      inputNamaController.text = json.decode(dataSession)['data']['akunpasien_nama_akun'];
      inputPasswordController.text =
      json.decode(dataSession)['data']['akunpasien_password'];
      inputPinController.text =
      json.decode(dataSession)['data']['akunpasien_password'];
      inputNoTelpController.text = json.decode(dataSession)['data']['akunpasien_no_telpn'];
    });
    String fotoProfile = json.decode(dataSession)['data']['akunpasien_password'];
//      print(fotoProfile);
    if (fotoProfile != '') {
      print('ada foto');
      setState(() {
        _imgString = fotoProfile;
      });
    } else {
      print('gak ada foto');
      setState(() {
        _imgString = _noImageString;
      });
    }
//    print(_imgString);
  }

  Widget _buildTitle() {
    return Text(
      "Edit Account",
      style: TextStyle(
          fontSize: 25,
//          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'WorkSansSemiBold'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: _buildTitle(),
          elevation: 0,
//          backgroundColor: Color(0xff10ac84),
        ),
        body: new ModalProgressHUD(inAsyncCall:_saving, child:

        Container(
//          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 150.0,
                    decoration: BoxDecoration(
//                        color: Color(0xff10ac84),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(56),
                            bottomLeft: Radius.circular(56))),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                          new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 90.0,
                                    height: 90.0,
                                    child:  ClipOval(
                                      child: Image.memory(
                                        base64Decode(_noImageString),
                                        height: 100,
                                        width: 100,
                                        scale: 1,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: InkWell(
                                  onTap: getImage,
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      !_status
                                          ? new CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      )
                                          : Container()
                                    ],
                                  )),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
//                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status
                                          ? _getEditIcon()
                                          : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? new Text('Nama',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)):
                                      new Text('Nama',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black))
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      focusNode: myFocusNodeNama,
                                      controller: inputNamaController,
                                      style:
                                      _status ? TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey) :
                                      TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Nama",
                                        hintStyle:
                                        TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text('Email ID',
                                          style:
                                          _status ? TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey):
                                          TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      focusNode: myFocusNodeEmail,
                                      controller: inputEmailController,
                                      keyboardType: TextInputType.text,
                                      style:
                                      _status ? TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey):
                                      TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID",
                                          hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'No Telepon',
                                        style:
                                        _status ? TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey) :
                                        TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      focusNode: myFocusNodeNoTelp,
                                      controller: inputNoTelpController,
                                      keyboardType: TextInputType.number,
                                      style: _status ? TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey):
                                      TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          hintText: "Telepon",
                                          hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Password',
                                        style: _status ? TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey):
                                        TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Pin Transaksi',
                                        style: _status ? TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey) :
                                        TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextField(
                                        obscureText: true,
                                        focusNode: myFocusNodePassword,
                                        controller: inputPasswordController,
                                        style: _status ? TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey):
                                        TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                            hintText: "Masukkan Password",
                                            hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey)),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      obscureText: true,
                                      focusNode: myFocusNodePin,
                                      controller: inputPinController,
                                      style: _status ? TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey):
                                      TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          hintText: "Masukkan pin transaksi",
                                          hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                      enabled: !_status,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text('Alamat',
                                          style: _status ? TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey):
                                          TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      focusNode: myFocusNodeAlamat,
                                      controller: inputAlamatController,
                                      style: _status ? TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey):
                                      TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      decoration: const InputDecoration(
                                          hintText: "Masukkan Alamat",
                                          hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        )
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  void simpanDataProfile() {
    setState(() {
      _saving = true;
    });
    Map data = {
      'id': id,
      'nama': inputNamaController.text,
      'alamat': inputAlamatController.text,
      'password': inputPasswordController.text,
      'email': inputEmailController.text,
      'key_transaksi': inputPinController.text,
      'no_telp': inputNoTelpController.text,
      'foto': _imgString
    };
    var body = json.encode(data);
    print(body);
    ApiProfile.simpanProfile(body).then((response) {
      var result = json.decode(response.body);
      if(result['meta']['success'] == true){
        getProfileUpdate();
      }
    });
  }

  getProfileUpdate() async {
    Map data = {
      'email': inputEmailController.text,
      'password': inputPasswordController.text
    };
    var body = json.encode(data);
    apiLogin.loginPost(body).then((response) {
      LocalStorage.sharedInstance
          .writeValue(key: 'session', value: response.body);
      getUserData();
      setState(() {
        _saving = false;
      });
    });
  }

  void keluar() {
    LocalStorage.sharedInstance.deleteValue('session');
    Navigator.of(context).pushReplacementNamed('/main');
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Simpan"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        simpanDataProfile();
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Batal"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

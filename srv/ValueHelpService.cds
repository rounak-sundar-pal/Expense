using {tripin.db.ValueHelp} from '../db/ValueHelp';


service ValueHelpService @(path: '/ValueHelpService') {

    entity TripVH     as projection on ValueHelp.TripVH;
    entity MemberVH   as projection on ValueHelp.MemberVH;
    entity CategoryVH as projection on ValueHelp.CategoryVH;

}

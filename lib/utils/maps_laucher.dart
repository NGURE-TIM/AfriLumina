
import 'package:afrilumina/core/core.dart';
import 'package:url_launcher/url_launcher.dart';


/// Opens Google Maps with the provided latitude and longitude coordinates.
///
/// This function constructs a Google Maps URL using the specified coordinates
/// and attempts to open it in an external application. If the operation fails,
/// it throws an exception.
///
/// ### Parameters:
/// - `latitude` (`double`): The latitude of the location to open in Google Maps.
/// - `longitude` (`double`): The longitude of the location to open in Google Maps.
///
/// ### Throws:
/// - `Exception` if launching the URL fails.
///
Future<void> openMap(double latitude, double longitude) async {
      String googleUrl =
          '$mapUrl$latitude,$longitude';
     
        try {
          
          await launchUrl(Uri.parse(googleUrl),
              mode: LaunchMode.externalApplication);
        } catch (e) {
          rethrow;
        }
   
    }
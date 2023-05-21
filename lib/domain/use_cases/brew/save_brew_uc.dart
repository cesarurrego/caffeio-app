import 'package:caffeio/app/brew/ratio/ratio_model.dart';
import 'package:caffeio/data/repositories/brew_repository.abs.dart';
import 'package:caffeio/domain/use_cases.abs.dart';
import 'package:caffeio/domain/use_cases/auth/get_profile_uc.dart';
import 'package:caffeio/entities/brew/brew.dart';

class SaveBrewUseCase extends FutureUseCase<void, RatioModelView> {
  final BrewRepository _brewRepository;
  final GetProfileUseCase _getProfileUseCase;

  SaveBrewUseCase(
    this._brewRepository,
    this._getProfileUseCase,
  );

  @override
  Future<void> call(RatioModelView params) async {
    final profile = await _getProfileUseCase().take(1).last;
    final brew = Brew(
      id: 0,
      methodId: params.method.id,
      ratio: params.ratio,
      water: params.water,
      coffeeGrams: params.gramsCoffee.toInt(),
      userId: profile?.id ?? "",
    );
    await _brewRepository.saveBrew(brew);
  }
}

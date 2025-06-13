import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/theme/text_styles.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/data/models/info_model.dart';
import 'package:rick_and_morty_app/data/repositories/character_response_repository.dart';
import 'package:rick_and_morty_app/ui/components/character_grid.dart';
import 'package:rick_and_morty_app/ui/components/main_text_field.dart';
import 'package:rick_and_morty_app/ui/components/pagination_controls.dart';
import 'package:rick_and_morty_app/ui/components/rick_and_morty_loading.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CharacterResponseRepository _characterResponseRepository =
      CharacterResponseRepository();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<CharacterModel> _characters = [];
  InfoModel? _info;
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _searchCharacters(name: _searchController.text);
    });
  }

  Widget _buildBodyContent() {
    if (_isLoading) {
      return RickAndMortyLoading();
    } else {
      return CharacterGrid(characters: _characters);
    }
  }

  Future<void> _searchCharacters({String name = ""}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final characterResponse = await _characterResponseRepository
          .getCharacterResponseModelByNameAndPage(
            name: name,
            page: _currentPage,
          );
      setState(() {
        _characters = characterResponse.characters;
        _info = characterResponse.info;
        _isLoading = false;
        _totalPages = _info!.pages;
      });
    } catch (e) {
      setState(() {
        _characters = [];
        _info = null;
        _isLoading = false;
        _totalPages = 0;
        _currentPage = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: AppColors.scaffoldBackground,
      body: Builder(
        builder: (BuildContext innerContext) {
          return Column(
            children: [
              MainTextField(controller: _searchController),
              Expanded(child: _buildBodyContent()),
              PaginationControls(
                currentPage: _currentPage,
                totalPages: _totalPages,
                onPageChanged: (newPage) {
                  if (newPage > 0 &&
                      newPage != _currentPage &&
                      newPage <= _totalPages) {
                    setState(() {
                      _currentPage = newPage;
                    });

                    _searchCharacters(name: _searchController.text);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Center(
        child: Text(
          "Rick and Morty Wiki",
          style: TextStyles.scaffoldAppBarTitle,
        ),
      ),
      backgroundColor: AppColors.scaffoldAppBarBackground,
    );
  }
}

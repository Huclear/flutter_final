import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/presentation/creators/creators_load_data_type.dart';
import 'package:recipe_sharing/presentation/creators/creators_screen_cubit.dart';
import 'package:recipe_sharing/presentation/creators/creators_screen_state.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import 'package:recipe_sharing/ui/creators/creator_card.dart';
import 'package:recipe_sharing/ui/recipes/recipes_screen/recipes_screen.dart';
import 'package:recipe_sharing/ui/stadard/error_info_page.dart';

class CreatorsScreen extends StatefulWidget {
  final CreatorsLoadDataType dataType;
  const CreatorsScreen({super.key, required this.dataType});

  @override
  State<CreatorsScreen> createState() => _CreatorsScreenState();
}

class _CreatorsScreenState extends State<CreatorsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreatorsScreenCubit()..setLoadDataType(widget.dataType),
      child: BlocBuilder<CreatorsScreenCubit, CreatorsScreenState>(
        builder: (blocContext, state) => Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/no_image.png',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.currentUserName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        state.currentUserEmail,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Recipes'),
                      selected: false,
                      onTap: () {
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RecipesScreen(
                                  loadedDataType: RecipesLoadedDataTypeAll(),
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No such route")),
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.shopping_basket_outlined),
                      title: Text('Own Recipes'),
                      selected: false,
                      onTap: () {
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RecipesScreen(
                                  loadedDataType: RecipesLoadedDataTypeOwn(),
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No such route")),
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.shopping_basket_outlined),
                      title: Text('Favorite Recipes'),
                      selected: false,
                      onTap: () {
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RecipesScreen(
                                  loadedDataType:
                                      RecipesLoadedDataTypeFavorites(),
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No such route")),
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Creators'),
                      selected:
                          state.creatorsLoadDataType ==
                          CreatorsLoadDataType.all,
                      onTap: () {
                        try {
                          if (state.creatorsLoadDataType !=
                              CreatorsLoadDataType.all) {
                            blocContext
                                .read<CreatorsScreenCubit>()
                                .setLoadDataType(CreatorsLoadDataType.all);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No such route")),
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.bookmark),
                      title: Text('Follows'),
                      selected:
                          state.creatorsLoadDataType ==
                          CreatorsLoadDataType.follows,
                      onTap: () {
                        try {
                          if (state.creatorsLoadDataType !=
                              CreatorsLoadDataType.follows) {
                            blocContext
                                .read<CreatorsScreenCubit>()
                                .setLoadDataType(CreatorsLoadDataType.follows);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No such route")),
                          );
                        }
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(state.creatorsLoadDataType.displayName),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 8),
                sliver: SliverToBoxAdapter(
                  child: state.creators is APIResultLoading
                      ? CircularProgressIndicator()
                      : state.creators is APIResultError
                      ? ErrorInfoPage(
                          errorInfo: state.creators.info ?? 'Unknown error',
                          onReloadPage: () {
                            blocContext.read<CreatorsScreenCubit>().loadData(
                              page: state.currentPage,
                            );
                          },
                        )
                      : Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 24,
                                  ),
                              itemCount: state.creators.data!.result.length,
                              itemBuilder: (context, index) {
                                final creator =
                                    state.creators.data!.result[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  child: CreatorCard(
                                    creator: creator,
                                    onAddToFollows: () {
                                      blocContext
                                          .read<CreatorsScreenCubit>()
                                          .triggerFollowsForCreator(
                                            creator.userID,
                                          );
                                    },
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RecipesScreen(
                                            loadedDataType:
                                                RecipesLoadedDataTypeCreator(
                                                  creatorId: creator.userID,
                                                ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

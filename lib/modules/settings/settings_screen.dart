import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/modules/edit_profile/edit_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:social_app/shared/components/componets.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // if (SocialCubit.get(context).userModel == null) {
        //   SocialCubit.get(context).getUserData();
        // }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var userposts=SocialCubit.get(context).userposts;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              SocialCubit.get(context).userModel != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  4.0,
                                ),
                                topRight: Radius.circular(
                                  4.0,
                                ),
                              ),
                              image: DecorationImage(
                                image: coverImage == null
                                    ? NetworkImage('${userModel!.cover}')
                                    : FileImage(coverImage) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: profileImage == null
                                ? NetworkImage('${userModel!.image}')
                                : FileImage(profileImage) as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${userModel!.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${userModel.bio}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '265',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '10k',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '64',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            navigateTo(context, NewPostScreen());
                          },
                          child: Text('Add Post'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            navigateTo(context, EditProfileScreen());
                          },
                          child: Icon(
                            IconBroken.Edit,
                            size: 16,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context).logOut(context);
                          },
                          child: Icon(
                            IconBroken.Logout,
                            size: 16,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(
                            userposts[index],
                            context,
                            index),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                        itemCount: userposts.length),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => Center(
              child: AdaptiveIndicator(
            os: getOS(),
          )),
        );
      },
    );
  }
}
Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.all(
          8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(height: 1.4),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      IconBroken.More_Circle,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).userpostslikes[index]}',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                ' comment',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}',
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).userpostsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );


